//
//  FavoritesTab.swift
//  final_00857051
//
//  Created by User03 on 2022/12/22.
//

import SwiftUI

struct FavoritesTab: View {
    @EnvironmentObject var saver: ChampionSaver
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.black, Color("CoolBlue")]), startPoint: .bottomLeading, endPoint: .topTrailing)
                VStack {
                    if saver.champions.isEmpty {
                        Text("You have no favorites.")
                            .font(.custom("FrizQua-ReguOS", size: 20))
                            .foregroundColor(.white)
                            .navigationBarTitle("")
                            .navigationBarHidden(true)
                    } else {
                        HStack {
                            Text("Favorites")
                                .font(.custom("FrizQuadrataBold", size: 40))
                                .foregroundColor(Color("LeagueGold"))
                            Spacer()
                            Button {
                                saver.champions.removeAll()
                            } label: {
                                ButtonView(color: "ButtonColor", image: "trash")
                            }
                        }
                        //.edgesIgnoringSafeArea(.top)
                        .padding(.horizontal)
                        List {
                            ForEach(saver.champions) {
                                champion in NavigationLink (
                                    destination: ChampionView(champion: champion),
                                    label: {
                                        ChampionRow(champion: champion, showSaveIcon: false)
                                    })
                            }
                            .onDelete { indexSet in
                                saver.champions.remove(atOffsets: indexSet)
                            }
                        }
                        .listStyle(InsetListStyle())
                        .navigationBarTitle("")
                        .navigationBarHidden(true)
                    }
                }
                .padding(.top, 50)
            }
            .edgesIgnoringSafeArea(.top)
        }
    }
}

struct FavoritesTab_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesTab()
            .environmentObject(ChampionSaver())
    }
}
