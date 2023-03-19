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
    
    func setValues(summonerEntity: CDSummoner, match: Match) {
        self.gameCreation = match.gameCreation
        self.id = match.id
        self.isWin = match.isWin
        self.lane = match.lane.rawValue
        self.version = match.version
        
        let myKDA = match.myKDA
        self.myAssist = myKDA[2]
        self.myChampionID = match.myChampionName
        self.myKill = myKDA[0]
        self.myDeath = myKDA[1]
        self.mySummonerName = match.mySummonerName
        
        let rivalKDA = match.rivalKDA
        self.enemyChampionID = match.rivalChampionName
        self.rivalKill = rivalKDA[0]
        self.rivalDeath = rivalKDA[1]
        self.rivalAssist = rivalKDA[2]
        self.rivalSummonerName = match.rivalSummonerName
        
        self.playedBy = summonerEntity
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


