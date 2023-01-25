//
//  Match.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/25.
//

import Foundation

struct Match {
    let match: CDMatch
    
    var myChampion: Champion {
        return Champion(name: match.myChmpionID ?? "Aatrox")
    }
    
    var rivalChampion: Champion {
        return Champion(name: match.enemyChampionID ?? "Aatrox")
    }
}
