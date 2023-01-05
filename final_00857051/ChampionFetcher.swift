//
//  ChampionFetcher.swift
//  final_00857051
//
//  Created by User03 on 2022/12/22.
//

import Foundation

class ChampionFetcher: ObservableObject {
    @Published var champions = [Champion]()
    @Published var showError = false
    @Published var isLoading = false
    
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
    
    func fetchData() {
        guard let urlString = "https://raw.githubusercontent.com/kevinwforney/LoLChampions/main/champions.json".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: urlString) else {
                  error = FetchError.invalidURL
                  return
        }
        URLSession.shared.dataTask(with: url) { data, response, error  in
            if let data = data {
                do {
                    //print(String(data: data, encoding: .utf8))
                    let champions = try JSONDecoder().decode([Champion].self, from: data)
                    DispatchQueue.main.async {
                        self.champions = champions
                        //print(self.champions.count)
                        self.error = nil
                        self.isLoading = false
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
