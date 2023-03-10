//
//  MatchDTO.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/10.
//

import Foundation

struct MatchDTO: Codable{

    let metadata: MetadataDTO
    let info: InfoDTO
    
    var isRankGame: Bool {
        info.isRankGame
    }
    
    var gameCreation: Int64 {
        info.gameCreation
    }
    
    func version() -> String {
        return metadata.getVersion()
    }
    
    func matchID() -> String {
        return metadata.getMatchID()
    }
    
    func laneByPuuid(_ puuid: String) -> Lane {
        return info.getLaneByPuuid(puuid: puuid)
    }
    
    func isWinByPuuid(_ puudid: String) -> Bool {
        return info.isWinByPuuid(puuid: puudid)
    }
    
    func isEqualMatchID(match: CDMatch) -> Bool {
        return self.matchID() == match.id
    }
    
    func myChampionByPuuid(_ puuid: String) -> Champion {
        return info.myChampionByPuuid(puuid: puuid)
    }
    
    func rivalChampionByPuuid(_ puuid: String) -> Champion {
        return info.rivalChampionByPuuid(puuid: puuid)
    }
    
    func myKDAByPuuid(_ puuid: String) -> [Int] {
        return info.myKDAByPuuid(puuid)
    }
    
    func rivalKDAByPuuid(_ puuid: String) -> [Int] {
        return info.rivalKDAByPuuid(puuid)
    }
    
    func rivalSummonerNameByPuuid(_ puuid: String) -> String {
        return info.rivalSummonerNameByPuuid(puuid)
    }
}
