//
//  SummonerFetcher.swift
//  final_00857051
//
//  Created by User03 on 2022/12/28.
//

import Foundation

let KEY = "RGAPI-0b45dc8e-5368-4373-9a2a-aac5a75adbbf"
class SummonerFetcher: ObservableObject {
    @Published var summoners = [Summoner]()
    @Published var masteries = [Mastery]()
    @Published var showError = false
    @Published var isLoading = false
    @Published var errorMessage = "Data not found"
    var error: Error? {
        willSet {
            DispatchQueue.main.async {
                self.showError = newValue != nil
            }
        }
    }

    enum FetchError: Error {
        case invalidURL
    }
    
    func fetchData(name: String) {
        print("start fetch")
        guard let urlString = "https://na1.api.riotgames.com/lol/summoner/v4/summoners/by-name/\(name)?api_key=\(KEY)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: urlString) else {
                  error = FetchError.invalidURL
                  return
        }
        URLSession.shared.dataTask(with: url) { data, response, error  in
            if let data = data {
                do {
                    if String(data: data, encoding: .utf8)! == "{\"status\":{\"message\":\"Data not found - summoner not found\",\"status_code\":404}}" {
                        print("No summoner of that name!")
                        self.errorMessage = "No summoner of that name!"
                    }
                    if String(data: data, encoding: .utf8)! == "{\"status\":{\"message\":\"Internal server error\",\"status_code\":500}}" {
                        print("Internal server error!")
                        self.errorMessage = "Internal server error!"
                    }
                    if String(data: data, encoding: .utf8)! == "{\"status\":{\"message\":\"Forbidden\",\"status_code\":403}}" {
                        print("API key unauthorized!")
                        self.errorMessage = "Invalid API key!"
                    }
                    let summoner = try JSONDecoder().decode(Summoner.self, from: data)
                    print(summoner)
                    DispatchQueue.main.async {
                        self.summoners.removeAll()
                        self.summoners.append(summoner)
                        //print(self.summoner)
                        self.error = nil
                        self.isLoading = false
                    }
                } catch  {
                    print(error)
                    self.error = error
                }
            } else if let error = error {
                self.error = error
            }
        }.resume()
    }
    
    func fetchMastery(summId: String) {
        guard let urlString = "https://na1.api.riotgames.com/lol/champion-mastery/v4/champion-masteries/by-summoner/\(summId)?api_key=\(KEY)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: urlString) else {
                  error = FetchError.invalidURL
                  return
        }
        URLSession.shared.dataTask(with: url) { data, response, error  in
            if let data = data {
                do {
                    let champions = try JSONDecoder().decode([Mastery].self, from: data)
                    DispatchQueue.main.async {
                        self.masteries = champions
                        self.error = nil
                    }
                } catch  {
                    self.error = error
                }
            } else if let error = error {
                self.error = error
            }
        }.resume()
    }
}
