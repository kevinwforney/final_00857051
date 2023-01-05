//
//  Champion.swift
//  final_00857051
//
//  Created by User19 on 2022/12/21.
//

import Foundation

struct Champion: Codable, Identifiable {
    let id: String
    let key: String
    let name: String
    let title: String
    let skins: [Skin]
    let lore: String
    let blurb: String
    let tags: [String]
    let info: Info
    let spells: [Spell]
    let passive: Passive
    var isSave: Bool?
}

struct Skin: Codable, Identifiable {
    let id: String
    let num: Int
    let name: String
}

struct Info: Codable {
    let attack: Int
    let defense: Int
    let magic: Int
    let difficulty: Int
}

struct Spell: Codable, Identifiable {
    let id: String
    let name: String
    let description: String
}

struct Passive: Codable {
    let name: String
    let description: String
    let image: String
}
