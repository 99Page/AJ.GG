//
//  InfoDTD.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/10.
//

import Foundation

struct InfoDTO: Codable, DummyCreatable {
    static func dummyDatas() -> [InfoDTO] {
        return [] 
    }
    
    static func dummyTopmMatch() -> InfoDTO {
        return InfoDTO(_gameCreation: 1, gameDuration: 1, gameEndTimestamp: 1, gameID: 1, _gameMode: "rank", gameName: "123", gameStartTimestamp: 1, gameType: "1", gameVersion: "1", mapID: 0, participants: ParticipantDTO.dummyDatas(), platformID: "123", queueID: 100, tournamentCode: "123")
    }
    
    typealias Dummy = InfoDTO
    
    private let _gameCreation, gameDuration, gameEndTimestamp, gameID: Int64
    private let _gameMode: String
    private let gameName: String
    private let gameStartTimestamp: Int
    private let gameType, gameVersion: String
    private let mapID: Int
    private let participants: ParticipantDTOs
    private let platformID: String
    private let queueID: Int
//    private let teams: Teams
    private let tournamentCode: String

    enum CodingKeys: String, CodingKey {
        case _gameCreation = "gameCreation"
        case gameDuration, gameEndTimestamp
        case gameID = "gameId"
        case _gameMode = "gameMode"
        case gameName, gameStartTimestamp, gameType, gameVersion
        case mapID = "mapId"
        case participants
        case platformID = "platformId"
        case queueID = "queueId"
//        case teams
        case tournamentCode
    }
    
    var isRankGame: Bool {
        return gameType == "MATCHED_GAME" && gameMode == "CLASSIC"
    }
    
    var gameCreation: Int64 {
        return _gameCreation
    }
    
    var gameMode: String {
        return _gameMode
    }
    
    func rivalSummonerNameByPuuid(_ puuid: String) -> String {
        if let rivalPuuid = rivalPuuidByPuuid(puuid: puuid) {
            return participants.first { $0.isSamePuuid(puuid: rivalPuuid) }?.summonerName ?? "페이커"
        }
        
        return "페이커"
    }
    
    func myKDAByPuuid(_ puuid: String) -> [Int] {
        return participants.first { $0.isSamePuuid(puuid: puuid) }?.kda ?? [-1, -1, -1]
    }
    
    func rivalKDAByPuuid(_ puuid: String) -> [Int] {
        if let rivalPuuid = rivalPuuidByPuuid(puuid: puuid) {
            return myKDAByPuuid(rivalPuuid)
        }
        
        return [-1, -1, -1]
    }
    
    
    func isSummonerRift() -> Bool {
        self.gameMode.isEqual(str: "CLASSIC")
    }
    
    func getLaneByPuuid(puuid: String) -> Lane {
        return participants.first { $0.isSamePuuid(puuid: puuid) }?.getLane() ?? .invalid
    }
    
    func getTeamIDByPuuid(puuid: String) -> Int? {
        return participants.first { $0.isSamePuuid(puuid: puuid)}?.getTeamID()
    }
    
    func rivalPuuidByPuuid(puuid: String) -> String? {
        let myTeamID = getTeamIDByPuuid(puuid: puuid) ?? -1 
        let myLane = getLaneByPuuid(puuid: puuid)
        
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
    
    func myChampionByPuuid(puuid: String) -> Champion {
        return participants.first { $0.isSamePuuid(puuid: puuid) }?.champion ?? Champion.optionalCase()

    }
    
    func rivalChampionByPuuid(puuid: String) -> Champion {
        if let enemyPuuid = rivalPuuidByPuuid(puuid: puuid) {
            return myChampionByPuuid(puuid: enemyPuuid)
        }
        
        return Champion.optionalCase()
    }
    
    func isWinByPuuid(puuid: String) -> Bool {
        return participants.first { $0.isSamePuuid(puuid: puuid) }?.isWin() ?? true 
    }
}

