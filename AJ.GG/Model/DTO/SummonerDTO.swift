//
//  SummonerDTO.swift
//  AJ.GG
//
//  Created by 노우영 on 2022/12/26.
//

import Foundation

struct SummonerDTO: Codable {
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
