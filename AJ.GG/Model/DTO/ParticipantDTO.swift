//
//  ParticipantDTO.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/10.
//

import Foundation

struct ParticipantDTO: Codable {
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
    let perks: PerksDTO
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
        case perks, pentaKills, physicalDamageDealt, physicalDamageDealtToChampions, physicalDamageTaken, profileIcon, pushPings, puuid, quadraKills
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


enum Lane: String, Codable {
    case invalid = "Invalid"
    case top = "TOP"
    case jungle = "JUNGLE"
    case mid = "MIDDLE"
    case adCarry = "BOTTOM"
    case supoort = "UTILITY"
    case none = "NONE"
}
