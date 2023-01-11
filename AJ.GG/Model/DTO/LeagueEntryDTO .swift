//
//  LeagueEntryDTO .swift
//  AJ.GG
//
//  Created by 노우영 on 2022/12/29.
//

import Foundation

// LEAGUE-V4 : Leagues by Summoner ID

struct LeagueEntryDTO: Codable {
    let leagueID, queueType, tier, rank: String
    let summonerID, summonerName: String
    let leaguePoints, wins, losses: Int
    let veteran, inactive, freshBlood, hotStreak: Bool

    enum CodingKeys: String, CodingKey {
        case leagueID = "leagueId"
        case queueType, tier, rank
        case summonerID = "summonerId"
        case summonerName, leaguePoints, wins, losses, veteran, inactive, freshBlood, hotStreak
    }
}

typealias LeagueEntryDTOs = [LeagueEntryDTO]
