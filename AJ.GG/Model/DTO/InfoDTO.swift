//
//  InfoDTD.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/10.
//

import Foundation

struct InfoDTO: Codable {
    let gameCreation, gameDuration, gameEndTimestamp, gameID: Int
    let gameMode, gameName: String
    let gameStartTimestamp: Int
    let gameType, gameVersion: String
    let mapID: Int
    let participants: ParticipantDTOs
    let platformID: String
    let queueID: Int
    let teams: Teams
    let tournamentCode: String

    enum CodingKeys: String, CodingKey {
        case gameCreation, gameDuration, gameEndTimestamp
        case gameID = "gameId"
        case gameMode, gameName, gameStartTimestamp, gameType, gameVersion
        case mapID = "mapId"
        case participants
        case platformID = "platformId"
        case queueID = "queueId"
        case teams, tournamentCode
    }
}
