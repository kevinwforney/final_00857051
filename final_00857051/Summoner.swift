//
//  Summoner.swift
//  final_00857051
//
//  Created by User03 on 2022/12/28.
//

import Foundation

struct Summoner: Codable, Identifiable {
    let id: String
    let name: String
    let profileIconId: Int
    let summonerLevel: Int
    //var isNotFound: Bool?
}

struct Mastery: Codable, Identifiable {
    let id: Int
    let championLevel: Int
    let chestGranted: Bool
    
    enum CodingKeys: String, CodingKey {
        case id = "championId"
        case championLevel = "championLevel"
        case chestGranted = "chestGranted"
    }
}
