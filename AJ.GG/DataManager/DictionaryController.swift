//
//  CDDictionaryCreator.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/02/06.
//

import Foundation

struct DictionaryController {
    static func summoner(_ summoner: Summoner, _ tier: LeagueTier) -> [String: Any] {
        let data: [String: Any] = [
            "id" : summoner.id,
            "puuid" : summoner.puuid,
            "leaguePoints" : tier.points,
            "summonerName" : summoner.summonerName,
            "rank" : tier.rank?.rawValue ?? "I",
            "tier" : tier.tier?.rawValue ?? "IRON",
            "profileIconID" : summoner.profileIconID
        ]
        
        return data
    }
    
    static func match(match: Match) -> [String: Any] {
        let data: [String: Any] = [
            "enemyChampionID" : match.rivalChampionName,
            "gameCreation" : match.gameCreation,
            "id" : match.id,
            "isWin" : match.isWin,
            "lane" : match.lane.rawValue,
            "myAssist" : match.myKDA[2],
            "myChampionID" : match.myChampionName,
            "myDeath" : match.myKDA[1],
            "myKill" : match.myKDA[0],
            "mySummonerName" : match.mySummonerName,
            "rivalAssist" : match.rivalKDA[2],
            "rivalDeath" : match.rivalKDA[1],
            "rivalKill" : match.rivalKDA[0],
            "rivalSummonerName" : match.rivalSummonerName,
            "version" : match.version
        ]
        
        return data
    }
}
