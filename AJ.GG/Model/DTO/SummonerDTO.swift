//
//  SummonerDTO.swift
//  AJ.GG
//
//  Created by 노우영 on 2022/12/26.
//

import Foundation

struct SummonerDTO: Codable, DummyCreatable {
    static func dummyData() -> SummonerDTO {
        return SummonerDTO(id: "0", accountID: "0", puuid: "123", name: "SwiftUI", profileIconID: 685, revisionDate: 0, summonerLevel: 0)
    }
    
    static func dummyDatas() -> [SummonerDTO] {
        return []
    }
    
    typealias Dummy = SummonerDTO
    
    let id, accountID, puuid, name: String
    let profileIconID, revisionDate, summonerLevel: Int

    enum CodingKeys: String, CodingKey {
        case id
        case accountID = "accountId"
        case puuid, name
        case profileIconID = "profileIconId"
        case revisionDate, summonerLevel
    }
    
    
}
