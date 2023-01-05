//
//  SummonerDetail.swift
//  final_00857051
//
//  Created by User03 on 2023/1/3.
//

import SwiftUI
import Kingfisher

struct SummonerDetail: View {
    var summoner: Summoner
    @EnvironmentObject var fetcher: SummonerFetcher
    @EnvironmentObject var championFetcher: ChampionFetcher
    @Binding var isShowing: Bool
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        ZStack {
            Image("wallpaper0")
                .resizable()
                .scaledToFill()
                .clipped()
                .offset(x: 200)
                .position(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
                .edgesIgnoringSafeArea(.all)
            LinearGradient(gradient: Gradient(colors: [Color.black, Color("CoolBlu")]), startPoint: .bottom, endPoint: .top)
            VStack {
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: columns) {
                        ForEach(fetcher.masteries) { mastery in
                            VStack {
                                ForEach(championFetcher.champions) { champion in
                                    if String(mastery.id) == champion.key {
                                        KFImage(URL(string: "https://ddragon.leagueoflegends.com/cdn/12.23.1/img/champion/\(champion.id).png"))
                                            .resizable()
                                            .scaledToFill()
                                            .clipped()
                                            .frame(width: 50, height: 50)
                                    }
                                }
                                Image("Champion_Mastery_Level_\(mastery.championLevel)_Flair")
                                    .resizable()
                                    .scaledToFill()
                                    .clipped()
                                    .frame(width: 40, height: 40)
                                    .offset(y: -10)
                            }
                        }
                    }
                }
                .onAppear {
                    isShowing = false
                    fetcher.fetchMastery(summId: summoner.id)
                    if championFetcher.champions.isEmpty {
                        championFetcher.fetchData()
                    }
                }
                .onDisappear {
                    isShowing = true
                }
                ZStack {
                    KFImage(URL(string: "https://ddragon.leagueoflegends.com/cdn/12.23.1/img/profileicon/\(summoner.profileIconId).png"))
                        .placeholder({
                            KFImage(URL(string: "https://ddragon.leagueoflegends.com/cdn/12.23.1/img/profileicon/\(summoner.profileIconId).png"))
                        })
                        .resizable()
                        .scaledToFill()
                        .frame(height: 100)
                        .clipped()
                    Color(.black)
                        .opacity(0.5)
                    HStack {
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text(summoner.name)
                                .font(.custom("FrizQua-ReguItalOS", size: 33))
                                .foregroundColor(.white)
                            Text("Level \(summoner.summonerLevel)")
                                .font(.custom("FrizQua-ReguOS", size: 20))
                                .foregroundColor(Color("LeagueGold"))
                        }
                        KFImage(URL(string: "https://ddragon.leagueoflegends.com/cdn/12.23.1/img/profileicon/\(summoner.profileIconId).png"))
                            .resizable()
                            .clipShape(Circle())
                            .scaledToFill()
                            .frame(width: 75, height: 75)
                    }
                    .padding(.horizontal)
                }
                .frame(height: 100)
                .cornerRadius(20)
                .padding([.bottom, .leading, .trailing])
            }
            .padding(.top)
        }
        //.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        //.edgesIgnoringSafeArea(.top)
    }
}
