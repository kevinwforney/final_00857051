//
//  final_00857051App.swift
//  final_00857051
//
//  Created by User03 on 2022/12/21.
//

import SwiftUI

@main
struct final_00857051App: App {
    @StateObject private var fetcher = ChampionFetcher()
    @StateObject private var sFetcher = SummonerFetcher()
    @StateObject private var saver = ChampionSaver()
    /*init() {
        for family in UIFont.familyNames {
             print(family)

             for names in UIFont.fontNames(forFamilyName: family){
             print("== \(names)")
             }
        }
    }*/
    var body: some Scene {
        WindowGroup {
            ContentView()
            .environmentObject(fetcher)
            .environmentObject(sFetcher)
            .environmentObject(saver)
        }
    }
}
