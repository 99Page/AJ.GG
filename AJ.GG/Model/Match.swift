//
//  Match.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/25.
//

import Foundation

struct Match {
    
    let myChampion: Champion
    let rivalChampion: Champion
    let isWin: Bool
    
    
    init(_ match: CDMatch) {
        self.myChampion = Champion(name: match.myChampionID ?? Champion.optionalCase().name)
        self.rivalChampion = Champion(name: match.myChampionID ?? Champion.optionalCase().name)
        self.isWin = match.isWin
    }
    
    init(_ match: MatchDTO, puuid: String) {
        self.myChampion = match.myChampionByPuuid(puuid)
        self.rivalChampion = match.rivalChampionByPuuid(puuid)
        self.isWin = match.isWinByPuuid(puuid)
    }
}
