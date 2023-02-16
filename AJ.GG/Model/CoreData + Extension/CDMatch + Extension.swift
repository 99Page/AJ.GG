//
//  Match + Extension.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/24.
//

import Foundation
import CoreData

extension CDMatch {
    func isEqual(_ object: CDMatch) -> Bool {
        return self.id == object.id
    }
}

extension CDMatch: AllSettable {
    func setValues(_ data: [String : Any]) {
        for (k, v) in data {
            self.setValue(v, forKey: k)
        }
    }
    
    func update(match: MatchDTO, summonerEntity: CDSummoner, puuid: String) {
        self.id = match.matchID()
        
        self.enemyChampionID = match.rivalChampionByPuuid(puuid).name
        
        let rivalKDA = match.rivalKDAByPuuid(puuid)
        self.rivalKill = Int16(rivalKDA[0])
        self.rivalDeath = Int16(rivalKDA[1])
        self.rivalAssist = Int16(rivalKDA[2])
        self.rivalSummonerName = match.rivalSummonerNameByPuuid(puuid)
        
        let myKDA = match.myKDAByPuuid(puuid)
        self.myKill = Int16(myKDA[0])
        self.myDeath = Int16(myKDA[1])
        self.myAssist = Int16(myKDA[2])
        self.myChampionID = match.myChampionByPuuid(puuid).name
        self.mySummonerName = summonerEntity.summonerName
        
        self.gameCreation = match.gameCreation
        self.isWin = match.isWinByPuuid(puuid)
        self.lane = match.laneByPuuid(puuid).rawValue
        self.playedBy = summonerEntity
        self.version = match.version()
    }
}


