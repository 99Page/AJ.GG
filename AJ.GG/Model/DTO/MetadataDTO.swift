//
//  MetaDTO.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/10.
//

import Foundation

struct MetadataDTO: Codable, DummyCreatable {
    static func dummyDatas() -> [MetadataDTO] {
        return [] 
    }
    
    typealias Dummy = MetadataDTO
    
    let dataVersion, matchID: String
    let participants: [String]

    enum CodingKeys: String, CodingKey {
        case dataVersion
        case matchID = "matchId"
        case participants
    }
    
    static func dummyTopmMatch() -> MetadataDTO {
        return MetadataDTO(dataVersion: "13.1", matchID: "", participants: [])
    }
    
    func getVersion() -> String {
        return dataVersion
    }
    
    func getMatchID() -> String {
        return matchID
    }
}
