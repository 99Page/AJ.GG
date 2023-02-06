//
//  Champion.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/10.
//

import Foundation
import Kingfisher

struct ChampionWithRate: Identifiable, Comparable {
    static func < (lhs: ChampionWithRate, rhs: ChampionWithRate) -> Bool {
        lhs.winRate > rhs.winRate
    }
    
    let id = UUID().uuidString
    let champion: Champion
    
    let win: Int
    let lose: Int
    
    var winRate: Double {
        Double(win) / Double(win+lose)
    }
    
    var loseRate: Double {
        Double(lose) / Double(win+lose)
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
    
    static func dummyData() -> Champion {
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
