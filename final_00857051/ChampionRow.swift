//
//  ChampionRow.swift
//  final_00857051
//
//  Created by User19 on 2022/12/21.
//

import SwiftUI
import Kingfisher

struct ChampionRow: View {
    @EnvironmentObject var saver: ChampionSaver
    var champion: Champion
    var showSaveIcon = true
    
    var isSave: Bool {
        champion.isSave ?? false
    }
    
    var body: some View {
        let splashUrl = "https://ddragon.leagueoflegends.com/cdn/img/champion/splash/\(champion.id)_0.jpg"
        ZStack {
            KFImage(URL(string: splashUrl))
                .placeholder({
                    KFImage(URL(string: splashUrl))
                })
                .resizable()
                .scaledToFill()
                .frame(height: 135)
                .clipped()
            Color(.black)
                .opacity(0.4)
//            LinearGradient(gradient: Gradient(colors: [Color.black, Color("Color")]), startPoint: .bottom, endPoint: .top)
//                .frame(height: 135)
//                .clipped()
            HStack {
                VStack(alignment: .leading) {
                    Text(champion.name)
                        .font(.custom("FrizQua-ReguOS", size: 33))
                        .foregroundColor(.white)
                    Divider()
                        .overlay(Color.white)
                    Text(champion.title)
                        .font(.custom("FrizQua-ReguItalOS", size: 20))
                        .foregroundColor(.white)
                }
            }
            .offset(y: 22)
            .padding(.horizontal)
            HStack {
                Spacer()
                if showSaveIcon {
                    Image(systemName: isSave ? "star.fill" : "star")
                        .resizable()
                        .offset(x: -10)
                        .scaleEffect(isSave ? 1.7 : 1.0)
                        .foregroundColor(isSave ? Color("LeagueGold") : .white)
                        .frame(width: 25, height: 25)
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.7)) {
                                if isSave == false {
                                    saver.champions.append(champion)
                                } else {
                                    saver.champions.removeAll {
                                        $0.id == champion.id
                                    }
                                }
                            }
                        }
                }
            }
            .padding(.trailing)
        }
        .frame(height: 135)
        .cornerRadius(20)
        //.padding(.horizontal)
    }
}

struct ChampionRow_Previews: PreviewProvider {
    static var previews: some View {
        ChampionRow(champion:
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
        //.previewLayout(.sizeThatFits)
    }
}
