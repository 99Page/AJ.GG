//
//  TeamDTO.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/10.
//

import Foundation

struct Team: Codable {
    let bans: BanDTOs
    let objectives: ObjectivesDTO
    let teamID: Int
    let win: Bool

    enum CodingKeys: String, CodingKey {
        case bans, objectives
        case teamID = "teamId"
        case win
    }
}

typealias Teams = [Team]
