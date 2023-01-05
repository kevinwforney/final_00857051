//
//  ChampionsTab.swift
//  final_00857051
//
//  Created by User03 on 2022/12/22.
//

import SwiftUI

struct ChampionsTab: View {
     let attrs = [
     NSAttributedString.Key.foregroundColor: UIColor(Color("LeagueGold")),
     NSAttributedString.Key.font: UIFont(name: "FrizQuadrataBold", size: 40)!
     ]
     let attributes = [
     NSAttributedString.Key.foregroundColor: UIColor(Color("LeagueGold")),
     NSAttributedString.Key.font: UIFont(name: "FrizQua-ReguOS", size: 20)!
     ]
     init() {
     //UINavigationBar.appearance().largeTitleTextAttributes = attrs
     UINavigationBar.appearance().tintColor = UIColor(Color("LeagueGold"))
     //UIBarButtonItem.appearance().setTitleTextAttributes(attributes, for: .normal)
     //UITableView.appearance().backgroundColor = UIColor(Color("LeagueGold"))
     //UITableViewCell.appearance().backgroundColor = UIColor(Color("LeagueGold"))
     UITabBar.appearance().tintColor = UIColor(Color("LeagueGold"))
     //UITableView.appearance().separatorStyle = .none
     }
    @EnvironmentObject var fetcher: ChampionFetcher
    @EnvironmentObject var saver: ChampionSaver
    @State private var searchText = ""
    
    var searchResult: [Champion] {
        var champions = [Champion]()
        var index: [Champion]
        if searchText.isEmpty {
            index = fetcher.champions
        } else {
            index = fetcher.champions.filter {
                $0.name.contains(searchText)
            }
        }
        for var champion in index {
            let isContain = saver.champions.contains {
                $0.id == champion.id
            }
            if isContain {
                champion.isSave = true
            } else {
                champion.isSave = false
            }
            champions.append(champion)
        }
        return champions
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.black, Color("CoolBlue")]), startPoint: .bottomLeading, endPoint: .topTrailing)
                VStack {
                    HStack {
                        Text("Champions")
                            .font(.custom("FrizQuadrataBold", size: 40))
                            .foregroundColor(Color("LeagueGold"))
                        Spacer()
                        Button {
                            fetcher.champions.removeAll()
                            fetcher.isLoading = true
                            fetcher.fetchData()
                        } label: {
                            ButtonView(color: "ButtonColor", image: "arrow.counterclockwise")
                        }
                    }
                    //.edgesIgnoringSafeArea(.top)
                    .padding(.horizontal)
                    TextField("Search", text: $searchText)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("LeagueGold"), lineWidth: 4))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding([.top, .leading, .trailing])
                    if !fetcher.isLoading {
                        List {
                            ForEach(searchResult) {
                                champion in NavigationLink (
                                    destination: ChampionView(champion: champion),
                                    label: {
                                        ChampionRow(champion: champion)
                                    })
                            }
                        }
                        .listStyle(InsetListStyle())
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .navigationBarTitle("")
                        .navigationBarHidden(true)
                        .alert(isPresented: $fetcher.showError, content: {
                            Alert(title: Text(fetcher.error?.localizedDescription ?? ""))
                        })
                        .onAppear {
                            if fetcher.champions.isEmpty {
                                fetcher.isLoading = true
                                fetcher.fetchData()
                            }
                        }
                    } else {
                        Spacer()
                        ProgressView()
                            .scaleEffect(x: 3, y: 3)
                            .progressViewStyle(CircularProgressViewStyle(tint: Color("LeagueGold")))
                        Spacer()
                    }
                }
                .padding(.top, 50)
            }
            .edgesIgnoringSafeArea(.top)
        }
    }
}

struct ChampionsTab_Previews: PreviewProvider {
    static var previews: some View {
        ChampionsTab()
            .environmentObject(ChampionFetcher())
    }
}
