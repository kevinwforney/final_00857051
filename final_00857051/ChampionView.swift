//
//  ChampionView.swift
//  final_00857051
//
//  Created by User03 on 2022/12/24.
//

import SwiftUI
import Kingfisher
import VTabView

struct ChampionView: View {
    var champion: Champion
    @State private var ReadMore = false
    var body: some View {
        ZStack {
            let bgUrl = "https://ddragon.leagueoflegends.com/cdn/img/champion/loading/\(champion.id)_0.jpg"
            KFImage(URL(string: bgUrl))
                .resizable()
                .scaledToFill()
                .clipped()
                .position(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
                .edgesIgnoringSafeArea(.all)
            LinearGradient(gradient: Gradient(colors: [Color.black, Color("CoolBlu")]), startPoint: .bottom, endPoint: .top)
            VTabView {
                // INTRO PAGE
                VStack {
                    Text(champion.title)
                        .font(.custom("FrizQua-ReguItalOS", size: 25))
                    Text(champion.name.uppercased())
                        .font(.custom("FrizQuadrataBold", size: 40))
                    Image(champion.tags[0])
                        .resizable()
                        .frame(width: 75, height: 75)
                    Text(champion.tags[0])
                        .font(.custom("FrizQua-ReguOS", size: 20))
                        .padding(.bottom)
                    Text(ReadMore ? champion.lore : champion.blurb)
                        .font(.custom("FrizQua-ReguItalOS", size: 15))
                        .padding(.horizontal, 50)
                        .fixedSize(horizontal: false, vertical: true)
                    Button {
                        ReadMore.toggle()
                    } label: {
                        ReadMore ? Text("Read Less").font(.custom("FrizQua-ReguItalOS", size: 15)) : Text("Read More").font(.custom("FrizQua-ReguItalOS", size: 15))
                    }
                }
                .tabItem {
                    Image(systemName: "square.fill")
                }
                // ABILITIES PAGE
                VStack {
                    HStack {
                        Text("ABILITIES")
                            .font(.custom("FrizQua-ReguItalOS", size: 40))
                        Spacer()
                    }
                    .padding(.leading)
                    Divider()
                        .overlay(Color.white)
                    VStack {
                        VStack {
                            HStack {
                                KFImage(URL(string: "https://ddragon.leagueoflegends.com/cdn/12.23.1/img/passive/\(champion.passive.image)"))
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                Text(champion.passive.name)
                                    .font(.custom("FrizQua-ReguOS", size: 30))
                                    .fixedSize(horizontal: false, vertical: true)
                                Spacer()
                            }
                            .padding(.horizontal)
                            Text(champion.passive.description)
                                .font(.custom("FrizQua-ReguItalOS", size: 15))
                                .lineLimit(2)
                                .padding(.horizontal)
                        }
                        ForEach(0...3, id: \.self) { i in
                            VStack {
                                HStack {
                                    KFImage(URL(string: "https://ddragon.leagueoflegends.com/cdn/12.23.1/img/spell/\(champion.spells[i].id).png"))
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                    Text(champion.spells[i].name)
                                        .font(.custom("FrizQua-ReguOS", size: 30))
                                        .fixedSize(horizontal: false, vertical: true)
                                    Spacer()
                                }
                                .padding(.horizontal)
                                Text(champion.spells[i].description)
                                    .font(.custom("FrizQua-ReguItalOS", size: 15))
                                    .lineLimit(2)
                                    .padding(.horizontal)
                            }
                        }
                    }
                }
                .tabItem {
                    Image(systemName: "circle.fill")
                }
                // SKINS PAGE
                VStack {
                    HStack {
                        Text("SKINS")
                            .font(.custom("FrizQua-ReguItalOS", size: 40))
                        Spacer()
                    }
                    .padding(.leading)
                    Divider()
                        .overlay(Color.white)
                    ScrollView(.horizontal, showsIndicators: false) {
                        let rows = [GridItem()]
                        LazyHGrid(rows: rows) {
                            ForEach(champion.skins, id: \.id) {
                                skin in
                                VStack {
                                    KFImage(URL(string: "https://ddragon.leagueoflegends.com/cdn/img/champion/splash/\(champion.id)_\(skin.num).jpg"))
                                        .resizable()
                                        .scaledToFit()
                                        .clipped()
                                    if skin.name == "default" {
                                        Text(champion.name)
                                            .font(.custom("FrizQua-ReguOS", size: 20))
                                    } else {
                                        Text(skin.name)
                                            .font(.custom("FrizQua-ReguOS", size: 20))
                                    }
                                }
                            }
                        }
                    }
                }
                .tabItem {
                    Image(systemName: "triangle.fill")
                }
            }
            .padding(.top)
            .foregroundColor(.white)
            .tabViewStyle(PageTabViewStyle())
        }
        //.navigationBarTitleDisplayMode(.large)
        //.edgesIgnoringSafeArea(.top)
    }
}

struct ChampionView_Previews: PreviewProvider {
    static var previews: some View {
        ChampionView(champion:
                        Champion(
                            id: "Diana",
                            key: "131",
                            name: "Diana",
                            title: "Scorn of the Moon",
                            skins: [
                                Skin(id: "131000", num: 0, name: "default"),
                                Skin(id: "131001", num: 1, name: "Dark Valkyrie Diana"),
                                Skin(id: "131002", num: 2, name: "Lunar Goddess Diana"),
                                Skin(id: "131003", num: 3, name: "Infernal Diana"),
                                Skin(id: "131011", num: 11, name: "Blood Moon Diana"),
                                Skin(id: "131012", num: 12, name: "Dark Waters Diana"),
                                Skin(id: "131018", num: 18, name: "Dragonslayer Diana"),
                                Skin(id: "131025", num: 25, name: "Battle Queen Diana"),
                                Skin(id: "131026", num: 26, name: "Prestige Battle Queen Diana"),
                                Skin(id: "131027", num: 27, name: "Sentinel Diana"),
                                Skin(id: "131037", num: 37, name: "Firecracker Diana"),
                                Skin(id: "131047", num: 47, name: "Winterblessed Diana")
                            ],
                            lore: "Bearing her crescent moonblade, Diana fights as a warrior of the Lunari—a faith all but quashed in the lands around Mount Targon. Clad in shimmering armor the color of winter snow at night, she is a living embodiment of the silver moon's power. Imbued with the essence of an Aspect from beyond Targon's towering summit, Diana is no longer wholly human, and struggles to understand her power and purpose in this world.",
                            blurb: "Bearing her crescent moonblade, Diana fights as a warrior of the Lunari—a faith all but quashed in the lands around Mount Targon. Clad in shimmering armor the color of winter snow at night, she is a living embodiment of the silver moon's power. Imbued...",
                            tags: ["Fighter", "Mage"],
                            info: Info(attack: 7, defense: 6, magic: 8, difficulty: 4),
                            spells: [
                                Spell(id: "DianaQ", name: "Crescent Strike", description: "Unleashes a bolt of lunar energy in an arc dealing magic damage. Afflicts enemies struck with Moonlight, revealing them if they are not stealthed for 3 seconds."),
                                Spell(id: "DianaOrbs", name: "Pale Cascade", description: "Diana creates three orbiting spheres that detonate on contact with enemies to deal damage in an area. She also gains a temporary shield that absorbs damage. If her third sphere detonates, the shield gains additional strength."),
                                Spell(id: "DianaTeleport", name: "Lunar Rush", description: "Becomes the living embodiment of the vengeful moon, dashing to an enemy and dealing magic damage.<br><br>Lunar Rush has no cooldown when used to dash to an enemy afflicted with Moonlight. All other enemies will have the Moonlight debuff removed regardless of whether they were the target of Lunar Rush."),
                                Spell(id: "DianaR", name: "Moonfall", description: "Diana reveals and draws in all nearby enemies and slows them. If Diana pulls in one or more enemy champions, the moonlight crashes down onto her after a short delay, dealing magic damage in an area around her, increased for each target beyond the first pulled.")
                            ],
                            passive: Passive(name: "Moonsilver Blade", description: "Every third strike cleaves nearby enemies for an additional magic damage. After casting a spell, Diana gains Attack Speed for her next 3 attacks.", image: "Diana_Passive_LunarBlade.png"),
                            isSave: true))
    }
}
