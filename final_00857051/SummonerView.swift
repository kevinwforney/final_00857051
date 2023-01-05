//
//  SummonerView.swift
//  final_00857051
//
//  Created by User03 on 2022/12/28.
//

import SwiftUI
import Kingfisher

struct SummonerView: View {
    var summoner: Summoner
    /*var isNotFound: Bool {
        summoner.isNotFound ?? false
    }*/
    
    var body: some View {
        VStack {
            ZStack {
                KFImage(URL(string: "https://ddragon.leagueoflegends.com/cdn/12.23.1/img/profileicon/\(summoner.profileIconId).png"))
                    .resizable()
                    .clipShape(Circle())
                    .overlay(BorderView(level: summoner.summonerLevel))
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                Text("\(summoner.summonerLevel)")
                    .font(.custom("FrizQua-ReguOS", size: 25))
                    .foregroundColor(.white)
                    .offset(x: 0, y: 115)
            }
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width)
    }
}

struct SummonerView_Previews: PreviewProvider {
    static var previews: some View {
        SummonerView(summoner: Summoner(id: "VRIy0CDICtkYF-A9WkHixQBvcFH1bIiBAEeP6f0fQtmGB5m0", name: "Nocturnyx", profileIconId: 4838, summonerLevel: 82))
    }
}

struct BorderView: View {
    let level: Int
    @State var borderImage = ""
    var body: some View {
        Image(borderImage).resizable().scaledToFit().frame(width: 380, height: 380)
        .onAppear {
            if level < 30 {
                borderImage = "Level_1_Summoner_Icon_Border"
            } else if level >= 30 && level < 50 {
                borderImage = "Level_30_Summoner_Icon_Border"
            } else if level >= 50 && level < 75 {
                borderImage = "Level_50_Summoner_Icon_Border"
            } else if level >= 75 && level < 100 {
                borderImage = "Level_75_Summoner_Icon_Border"
            } else if level >= 100 && level < 125 {
                borderImage = "Level_100_Summoner_Icon_Border"
            } else if level >= 125 && level < 150 {
                borderImage = "Level_125_Summoner_Icon_Border"
            } else if level >= 150 && level < 175 {
                borderImage = "Level_150_Summoner_Icon_Border"
            } else if level >= 175 && level < 200 {
                borderImage = "Level_175_Summoner_Icon_Border"
            } else if level >= 200 && level < 225 {
                borderImage = "Level_200_Summoner_Icon_Border"
            } else if level >= 225 && level < 250 {
                borderImage = "Level_225_Summoner_Icon_Border"
            } else if level >= 250 && level < 275 {
                borderImage = "Level_250_Summoner_Icon_Border"
            } else if level >= 275 && level < 300 {
                borderImage = "Level_275_Summoner_Icon_Border"
            } else if level >= 300 && level < 325 {
                borderImage = "Level_300_Summoner_Icon_Border"
            } else if level >= 325 && level < 350 {
                borderImage = "Level_325_Summoner_Icon_Border"
            } else if level >= 350 && level < 375 {
                borderImage = "Level_350_Summoner_Icon_Border"
            } else if level >= 375 && level < 400 {
                borderImage = "Level_375_Summoner_Icon_Border"
            } else if level >= 400 && level < 425 {
                borderImage = "Level_400_Summoner_Icon_Border"
            } else if level >= 425 && level < 450 {
                borderImage = "Level_425_Summoner_Icon_Border"
            } else if level >= 450 && level < 475 {
                borderImage = "Level_450_Summoner_Icon_Border"
            } else if level >= 475 && level < 500 {
                borderImage = "Level_475_Summoner_Icon_Border"
            } else {
                borderImage = "Level_500_Summoner_Icon_Border"
            }
        }
    }
}
