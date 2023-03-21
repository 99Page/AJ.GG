//
//  Champion.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/10.
//

import Foundation
import Kingfisher

struct ChampionWithRate: Identifiable, Comparable, DummyCreatable {
    
    static func dummyTopmMatch() -> ChampionWithRate {
        return dummyDatas().randomElement()!
    }
    
    static func dummyDatas() -> [ChampionWithRate] {
        return [
            ChampionWithRate(champion: Champion(name: "Aatrox"), win: 10, lose: 3),
            ChampionWithRate(champion: Champion(name: "Gwen"), win: 5, lose: 1),
            ChampionWithRate(champion: Champion(name: "Singed"), win: 6, lose: 2),
            ChampionWithRate(champion: Champion(name: "Ryze"), win: 3, lose: 10),
            ChampionWithRate(champion: Champion(name: "Ashe"), win: 21, lose: 4),
        ]
        
    }
    
    typealias Dummy = ChampionWithRate
    
    
    static func < (lhs: ChampionWithRate, rhs: ChampionWithRate) -> Bool {
        
        if lhs.winRate != rhs.winRate {
            return lhs.winRate > rhs.winRate
        } else {
            if lhs.total != rhs.total {
                return lhs.total > rhs.total
            } else {
                return lhs.champion.name > rhs.champion.name
            }
        }
    }
    
    let id = UUID().uuidString
    let champion: Champion
    
    let win: Int
    let lose: Int
    
    var total: Int {
        win+lose
    }
    
    var winRate: Double {
        Double(win) / Double(total)
    }
    
    var loseRate: Double {
        Double(lose) / Double(total)
    }
}

struct Champion: DummyCreatable, Identifiable, Hashable {
    

    
    typealias Dummy = Champion
    
    let id = UUID().uuidString
    private let _name: String
    
    init(name: String) {
        self._name = name
    }
    
    var name: String {
        _name
    }
    
    var image: KFImage {
        KFImage(URL(string: RiotURL.championSquareAsset(champion: self.name).url))
    }
    
    static func dummyTopmMatch() -> Champion {
        let championNames = ["Aatrox", "Garen", "Darius"]
        return Champion(name: championNames.randomElement() ?? "Aatrox")
    }
    
    static func dummyDatas() -> [Champion] {
        let championNames = ["Aatrox", "Garen", "Darius", "Gwen"]
        return championNames.map { Champion(name: $0)}
    }
    
    static func optionalCase() -> Champion {
        return Champion(name: "Poro")
    }
}
