//
//  MatchDTO.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/10.
//

import Foundation

struct MatchDTO: Codable {
    let metadata: MetadataDTO
    let info: InfoDTO
    
    func getVersion() -> String {
        return metadata.getVersion()
    }
    
    func getMatchID() -> String {
        return metadata.getMatchID()
    }
    
    func getLaneByPuuid(puuid: String) -> Lane? {
        return info.getLaneByPuuid(puuid: puuid)
    }
    
    func isWingByPuuid(puudid: String) -> Bool {
        return info.isWinByPuuid(puuid: puudid)
    }
    
    func isEqualMatchID(match: Match) -> Bool {
        return self.getMatchID() == match.id
    }
    
    func getChampionNameByPuuid(puuid: String) -> String? {
        return info.getChampionNameByPuuid(puuid: puuid)
    }
    
    func getEnemyChampionNameByPuuid(puuid: String) -> String? {
        return info.getEnemyChmapionByPuuid(puuid: puuid)
    }
}
