//
//  MatchDTO.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/10.
//

import Foundation

struct MatchDTO: Codable, DummyCreatable {
    static func dummyDatas() -> [MatchDTO] {
        return [] 
    }
    
    static func dummyData() -> MatchDTO {
        return MatchDTO(metadata: MetadataDTO.dummyData(), info: InfoDTO.dummyData())
    }
    
    typealias Dummy = MatchDTO
    
    let metadata: MetadataDTO
    let info: InfoDTO
    
    var gameCreation: Int64 {
        info.gameCreation
    }
    
    func getVersion() -> String {
        return metadata.getVersion()
    }
    
    func getMatchID() -> String {
        return metadata.getMatchID()
    }
    
    func getLaneByPuuid(puuid: String) -> Lane? {
        return info.getLaneByPuuid(puuid: puuid)
    }
    
    func isWinByPuuid(puudid: String) -> Bool {
        return info.isWinByPuuid(puuid: puudid)
    }
    
    func isEqualMatchID(match: CDMatch) -> Bool {
        return self.getMatchID() == match.id
    }
    
    func myChampion(puuid: String) -> Champion {
        return info.myChampionByPuuid(puuid: puuid)
    }
    
    func rivalChampion(puuid: String) -> Champion {
        return info.rivalChampionByPuuid(puuid: puuid)
    }
}
