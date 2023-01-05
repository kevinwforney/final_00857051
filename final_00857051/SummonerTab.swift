//
//  SummonerTab.swift
//  final_00857051
//
//  Created by User03 on 2022/12/28.
//

import SwiftUI
import Kingfisher

struct SummonerTab: View {
    @EnvironmentObject var fetcher: SummonerFetcher
    @EnvironmentObject var saver: ChampionSaver
    @Binding var viewMode: Int
    @State private var searchText = ""
    @State private var isShowing: Bool = true
    @State private var showSheet = false
    func LogOut() {
        saver.UserData.removeAll()
        viewMode = 2
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.black, Color("CoolBlue")]), startPoint: .bottomLeading, endPoint: .topTrailing)
                VStack {
                    HStack {
                        Text("Summoner")
                            .font(.custom("FrizQuadrataBold", size: 40))
                            .foregroundColor(Color("LeagueGold"))
                        Spacer()
                    }
                    //.edgesIgnoringSafeArea(.top)
                    .padding(.horizontal)
                    TextField("Search summoner name", text: $searchText, onCommit: {
                        fetcher.isLoading = true
                        isShowing = false
                        fetcher.fetchData(name: searchText)
                        //print(fetcher.summoners)
                    })
                    .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("LeagueGold"), lineWidth: 4))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding([.top, .leading, .trailing])
                    if isShowing {
                        VStack {
                            Spacer()
                            Image("logo")
                                .resizable()
                                .scaledToFit()
                                .padding(.horizontal, 50)
                            Text("Version 12.23.1")
                                .font(.custom("FrizQua-ReguOS", size: 30))
                            Spacer()
                            Button {
                                //print("Share Button Pressed!")
                                showSheet = true
                            } label: {
                                ButtonView(color: "ButtonColorInv", image: "square.and.arrow.up")
                            }
                            .sheet(isPresented: $showSheet) {
                                ShareSheet()
                            }
                            Button {
                                //print("LogOut Button Pressed!")
                                LogOut()
                            } label: {
                                ButtonView(color: "ButtonColor", image: "power")
                            }
                            Spacer()
                            Text("App designed by 張青雲")
                                .font(.custom("FrizQua-ReguItalOS", size: 20))
                        }
                        .foregroundColor(Color("LeagueGold"))
                    } else {
                        VStack {
                            Spacer()
                            if !fetcher.isLoading {
                                ForEach(fetcher.summoners) {
                                    summoner in NavigationLink (
                                        destination: SummonerDetail(summoner: summoner, isShowing: $isShowing), label: {
                                            SummonerView(summoner: summoner)
                                        }
                                    )
                                }
                            } else {
                                ProgressView()
                                    .scaleEffect(x: 3, y: 3)
                                    .progressViewStyle(CircularProgressViewStyle(tint: Color("LeagueGold")))
                            }
                            Spacer()
                        }
                    }
                    //.navigationBarTitle("Summoner")
                    //.navigationBarHidden(true)
                }
                .padding(.top, 50)
                .alert(isPresented: $fetcher.showError, content: {
                    Alert(title: Text(fetcher.errorMessage))
                    //Alert(title: Text(fetcher.error?.localizedDescription ?? ""))
                })
            }
            .edgesIgnoringSafeArea(.top)
        }
    }
}
