//
//  MetaDTO.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/10.
//

import Foundation

struct MetadataDTO: Codable {
    let dataVersion, matchID: String
    let participants: [String]

    enum CodingKeys: String, CodingKey {
        case dataVersion
        case matchID = "matchId"
        case participants
    }
}
