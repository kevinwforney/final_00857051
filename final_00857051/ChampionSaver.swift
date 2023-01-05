//
//  ChampionSaver.swift
//  final_00857051
//
//  Created by User03 on 2022/12/22.
//

import SwiftUI

class ChampionSaver: ObservableObject {
    @AppStorage("champions") var championsData: Data?
    @AppStorage("UserData") var UserDataStorage: Data?
    
    @Published var champions = [Champion]() {
        didSet {
            do {
                championsData = try JSONEncoder().encode(champions)
            } catch {
                print("error")
            }
        }
    }
    
    @Published var UserData = [UserTokenForLogin]() {
        didSet{
            let encoder = JSONEncoder()
            do {
                UserDataStorage = try encoder.encode(UserData)
            } catch {
                print(error)
            }
        }
    }
    
    init() {
        if let championsData = championsData {
            let decoder = JSONDecoder()
            do {
                champions = try decoder.decode([Champion].self, from: championsData)
            } catch  {
                print("error")
            }
        }
        
        if let UserDataStorage = UserDataStorage{
            let decoder = JSONDecoder()
            do {
                UserData = try decoder.decode([UserTokenForLogin].self, from: UserDataStorage)
            } catch  {
                print(error)
            }
        }
    }
}
