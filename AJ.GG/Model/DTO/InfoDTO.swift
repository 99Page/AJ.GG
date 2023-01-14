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
    
  
    
    func getLaneByPuuid(puuid: String) -> Lane? {
        return participants.first { $0.isSamePuuid(puuid: puuid) }?.getLane()
    }
    
    func getTeamIDByPuuid(puuid: String) -> Int? {
        return participants.first { $0.isSamePuuid(puuid: puuid)}?.getTeamID()
    }
    
    func getEnemyPuuidByPuuid(puuid: String) -> String? {
        let myTeamID = getTeamIDByPuuid(puuid: puuid)!
        let myLane = getLaneByPuuid(puuid: puuid)!
        
//        print("myTeamID: \(myTeamID), myLane: \(myLane)")
//        
//        participants.forEach { dto in
//            print("name: \(dto.summonerName) teamID: \(dto.teamID), individualPosition: \(dto.individualPosition)")
//            print("\(dto.summonerName)이랑 라인이 같은가? \(dto.isSameLane(lane: myLane))")
//            print("\(dto.summonerName)이랑 적인가? \(!dto.isSameTeam(teamID: myTeamID))")
//            print("\(dto.summonerName)이랑 맞라이너인가? \(dto.isEnemy(teamID: myTeamID, lane: myLane))")
//        }
        return participants.first { $0.isEnemy(teamID: myTeamID, lane: myLane)}?.getPuuid()
    }
    
    func getChampionNameByPuuid(puuid: String) -> String? {
        return participants.first { $0.isSamePuuid(puuid: puuid) }?.getChampionName()

    }
    
    func getEnemyChmapionByPuuid(puuid: String) -> String? {
        if let enemyPuuid = getEnemyPuuidByPuuid(puuid: puuid) {
            return getChampionNameByPuuid(puuid: enemyPuuid)
        }
        
        return nil
    }
    
    func isWinByPuuid(puuid: String) -> Bool {
        return participants.first { $0.isSamePuuid(puuid: puuid) }?.isWin() ?? true 
    }
}
