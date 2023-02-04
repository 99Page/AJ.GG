//
//  ParticipantDTO.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/10.
//

import Foundation

struct ParticipantDTO: Codable, DummyCreatable {
    static func dummyDatas() -> [ParticipantDTO] {
        return [dummyData(), dummyData()]
    }
    
    static func dummyData() -> ParticipantDTO {
        ParticipantDTO(allInPings: 0, assistMePings: 0, assists: 1, baitPings: 0, baronKills: 0, basicPings: 0, bountyLevel: 0, champExperience: 1, champLevel: 1, championID: 1, championName: "Aatrox", championTransform: 1, commandPings: 1, consumablesPurchased: 1, damageDealtToBuildings: 1, damageDealtToObjectives: 1, damageDealtToTurrets: 1, damageSelfMitigated: 1, dangerPings: 1, deaths: 1, detectorWardsPlaced: 1, doubleKills: 1, dragonKills: 1, eligibleForProgression: false, enemyMissingPings: 1, enemyVisionPings: 1, firstBloodAssist: false, firstBloodKill: false, firstTowerAssist: false, firstTowerKill: false, gameEndedInEarlySurrender: false, gameEndedInSurrender: false, getBackPings: 0, goldEarned: 0, goldSpent: 0, holdPings: 0, individualPosition: Lane.mid, inhibitorKills: 0, inhibitorTakedowns: 0, inhibitorsLost: 0, item0: 0, item1: 0, item2: 0, item3: 0, item4: 0, item5: 0, item6: 0, itemsPurchased: 0, killingSprees: 0, kills: 0, lane: Lane.mid, largestCriticalStrike: 0, largestKillingSpree: 0, largestMultiKill: 0, longestTimeSpentLiving: 0, magicDamageDealt: 0, magicDamageDealtToChampions: 0, magicDamageTaken: 0, needVisionPings: 0, neutralMinionsKilled: 0, nexusKills: 0, nexusLost: 0, nexusTakedowns: 0, objectivesStolen: 0, objectivesStolenAssists: 0, onMyWayPings: 0, participantID: 0, pentaKills: 0, physicalDamageDealt: 0, physicalDamageDealtToChampions: 0, physicalDamageTaken: 0, profileIcon: 0, pushPings: 0, puuid: "123", quadraKills: 0, riotIDName: "SwiftUI", riotIDTagline: "SwiftUI", role: "??", sightWardsBoughtInGame: 0, spell1Casts: 0, spell2Casts: 0, spell3Casts: 0, spell4Casts: 0, summoner1Casts: 0, summoner1ID: 0, summoner2Casts: 0, summoner2ID: 0, summonerID: "", summonerLevel: 0, summonerName: "SwiftUI", teamEarlySurrendered: false, teamID: 100, teamPosition: "MID", timeCCingOthers: 0, timePlayed: 0, totalDamageDealt: 0, totalDamageDealtToChampions: 0, totalDamageShieldedOnTeammates: 0, totalDamageTaken: 0, totalHeal: 0, totalHealsOnTeammates: 0, totalMinionsKilled: 0, totalTimeCCDealt: 0, totalTimeSpentDead: 0, totalUnitsHealed: 0, tripleKills: 0, trueDamageDealt: 0, trueDamageDealtToChampions: 0, trueDamageTaken: 0, turretKills: 0, turretTakedowns: 0, turretsLost: 0, unrealKills: 0, visionClearedPings: 0, visionScore: 0, visionWardsBoughtInGame: 0, wardsKilled: 0, wardsPlaced: 0, win: [true, false].randomElement() ?? true )
    }
    
    typealias Dummy = ParticipantDTO
    
    let allInPings, assistMePings, assists, baitPings: Int
    let baronKills, basicPings, bountyLevel: Int
//    let challenges: [String: Double]
    let champExperience, champLevel, championID: Int
    let championName: String
    let championTransform, commandPings, consumablesPurchased, damageDealtToBuildings: Int
    let damageDealtToObjectives, damageDealtToTurrets, damageSelfMitigated, dangerPings: Int
    let deaths, detectorWardsPlaced, doubleKills, dragonKills: Int
    let eligibleForProgression: Bool
    let enemyMissingPings, enemyVisionPings: Int
    let firstBloodAssist, firstBloodKill, firstTowerAssist, firstTowerKill: Bool
    let gameEndedInEarlySurrender, gameEndedInSurrender: Bool
    let getBackPings, goldEarned, goldSpent, holdPings: Int
    let individualPosition: Lane
    let inhibitorKills, inhibitorTakedowns, inhibitorsLost, item0: Int
    let item1, item2, item3, item4: Int
    let item5, item6, itemsPurchased, killingSprees: Int
    let kills: Int
    let lane: Lane
    let largestCriticalStrike, largestKillingSpree, largestMultiKill, longestTimeSpentLiving: Int
    let magicDamageDealt, magicDamageDealtToChampions, magicDamageTaken, needVisionPings: Int
    let neutralMinionsKilled, nexusKills, nexusLost, nexusTakedowns: Int
    let objectivesStolen, objectivesStolenAssists, onMyWayPings, participantID: Int
    let pentaKills: Int
//    let perks: PerksDTO
    let physicalDamageDealt, physicalDamageDealtToChampions, physicalDamageTaken, profileIcon: Int
    let pushPings: Int
    let puuid: String
    let quadraKills: Int
    let riotIDName, riotIDTagline, role: String
    let sightWardsBoughtInGame, spell1Casts, spell2Casts, spell3Casts: Int
    let spell4Casts, summoner1Casts, summoner1ID, summoner2Casts: Int
    let summoner2ID: Int
    let summonerID: String
    let summonerLevel: Int
    let summonerName: String
    let teamEarlySurrendered: Bool
    let teamID: Int
    let teamPosition: String
    let timeCCingOthers, timePlayed, totalDamageDealt, totalDamageDealtToChampions: Int
    let totalDamageShieldedOnTeammates, totalDamageTaken, totalHeal, totalHealsOnTeammates: Int
    let totalMinionsKilled, totalTimeCCDealt, totalTimeSpentDead, totalUnitsHealed: Int
    let tripleKills, trueDamageDealt, trueDamageDealtToChampions, trueDamageTaken: Int
    let turretKills, turretTakedowns, turretsLost, unrealKills: Int
    let visionClearedPings, visionScore, visionWardsBoughtInGame, wardsKilled: Int
    let wardsPlaced: Int
    let win: Bool

    enum CodingKeys: String, CodingKey {
        case allInPings, assistMePings, assists, baitPings, baronKills, basicPings, bountyLevel
        // case challenges
        case champExperience, champLevel
        case championID = "championId"
        case championName, championTransform, commandPings, consumablesPurchased, damageDealtToBuildings, damageDealtToObjectives, damageDealtToTurrets, damageSelfMitigated, dangerPings, deaths, detectorWardsPlaced, doubleKills, dragonKills, eligibleForProgression, enemyMissingPings, enemyVisionPings, firstBloodAssist, firstBloodKill, firstTowerAssist, firstTowerKill, gameEndedInEarlySurrender, gameEndedInSurrender, getBackPings, goldEarned, goldSpent, holdPings, individualPosition, inhibitorKills, inhibitorTakedowns, inhibitorsLost, item0, item1, item2, item3, item4, item5, item6, itemsPurchased, killingSprees, kills, lane, largestCriticalStrike, largestKillingSpree, largestMultiKill, longestTimeSpentLiving, magicDamageDealt, magicDamageDealtToChampions, magicDamageTaken, needVisionPings, neutralMinionsKilled, nexusKills, nexusLost, nexusTakedowns, objectivesStolen, objectivesStolenAssists, onMyWayPings
        case participantID = "participantId"
//        case perks
        case pentaKills, physicalDamageDealt, physicalDamageDealtToChampions, physicalDamageTaken, profileIcon, pushPings, puuid, quadraKills
        case riotIDName = "riotIdName"
        case riotIDTagline = "riotIdTagline"
        case role, sightWardsBoughtInGame, spell1Casts, spell2Casts, spell3Casts, spell4Casts, summoner1Casts
        case summoner1ID = "summoner1Id"
        case summoner2Casts
        case summoner2ID = "summoner2Id"
        case summonerID = "summonerId"
        case summonerLevel, summonerName, teamEarlySurrendered
        case teamID = "teamId"
        case teamPosition, timeCCingOthers, timePlayed, totalDamageDealt, totalDamageDealtToChampions, totalDamageShieldedOnTeammates, totalDamageTaken, totalHeal, totalHealsOnTeammates, totalMinionsKilled, totalTimeCCDealt, totalTimeSpentDead, totalUnitsHealed, tripleKills, trueDamageDealt, trueDamageDealtToChampions, trueDamageTaken, turretKills, turretTakedowns, turretsLost, unrealKills, visionClearedPings, visionScore, visionWardsBoughtInGame, wardsKilled, wardsPlaced, win
    }
    
    var kda: [Int] {
        return [self.kills, self.deaths, self.assists]
    }
    
    var champion: Champion {
        return Champion(name: self.championName)
    }
    
    func getLane() -> Lane {
        return self.individualPosition
    }
    
    func getChampionName() -> String {
        return self.championName
    }
    
    func getTeamID() -> Int {
        return self.teamID
    }
    
    func getPuuid() -> String {
        return self.puuid
    }
    
    func isSameTeam(teamID: Int) -> Bool {
        return self.teamID == teamID
    }
    
    func isSameLane(lane: Lane) -> Bool {
        return self.getLane() == lane
    }
    
    func isEnemy(teamID: Int, lane: Lane) -> Bool {
        return !isSameTeam(teamID: teamID) && isSameLane(lane: lane)
    }
    
    func isSamePuuid(puuid: String) -> Bool {
        return self.puuid == puuid
    }
    
    func isWin() -> Bool {
        return self.win
    }
}

typealias ParticipantDTOs = [ParticipantDTO]


enum Lane: String, Codable, CaseIterable, Equatable {
    case invalid = "Invalid"
    case top = "TOP"
    case jungle = "JUNGLE"
    case mid = "MIDDLE"
    case adCarry = "BOTTOM"
    case supoort = "UTILITY"
    case none = "NONE"
    
    static func selectableLanes() -> [Lane] {
        return [.top, .jungle, .mid, .adCarry, .supoort, .none]
    }
    
    func isEqual(_ lane: Lane) -> Bool {
        return self == lane
    }

    var imageName: String {
        switch self {
        case .invalid:
            return "Lane_None"
        case .top:
            return "Lane_Top"
        case .jungle:
            return "Lane_Jungle"
        case .mid:
            return "Lane_Middle"
        case .adCarry:
            return "Lane_Bottom"
        case .supoort:
            return "Lane_Utility"
        case .none:
            return "Lane_None"
        }
    }
}
