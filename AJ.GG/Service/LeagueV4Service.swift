//
//  LeagueV4Service.swift
//  AJ.GG
//
//  Created by 노우영 on 2022/12/29.
//

import Foundation
import Alamofire

protocol LeagueV4ServiceEnable {
    func leaguesBySummonerID(summonerID: String) async -> Result<LeagueEntryDTOs, NetworkError>
    func leagueTierBySummonerID(summonerID: String) async -> Result<LeagueTier?, NetworkError>
}

class LeagueV4Serivce: RiotAuthorizaiton, LeagueV4ServiceEnable {
    
    func leaguesBySummonerID(summonerID: String) async -> Result<LeagueEntryDTOs, NetworkError> {
        
        let url = "\(RIOT_API_URL)/lol/league/v4/entries/by-summoner/\(summonerID)"
        let response = await AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).serializingDecodable(LeagueEntryDTOs.self).response
        
        if response.error != nil {
            print(response.debugDescription)
        }
        
        let result = response.result
        return result.mapError { err in
            let serverError = response.data.flatMap { try? JSONDecoder().decode(ServerError.self, from: $0) }
            return NetworkError(AFError: err, serverError: serverError)
        }
    }
    
    func leagueTierBySummonerID(summonerID: String) async -> Result<LeagueTier?, NetworkError> {
        
        let result = await self.leaguesBySummonerID(summonerID: summonerID)
        
        switch result {
            
        case .success(let value):
            if let first = value.first {
                let tier = LeagueTier(tier: Tier(rawValue: first.tier),
                                      rank: Rank(rawValue: first.rank),
                                      points: Int32(first.leaguePoints))
                return .success(tier)
            }
            return .success(nil)
            
        case .failure(let err):
            return .failure(err)
        }
    }
}

class MockSuccessLeagueV4Service: LeagueV4ServiceEnable {
    func leaguesBySummonerID(summonerID: String) async -> Result<LeagueEntryDTOs, NetworkError> {
        return .success([LeagueEntryDTO(leagueID: "123", queueType: "123", tier: "123", rank: "123", summonerID: "123", summonerName: "123", leaguePoints: 12, wins: 13, losses: 23, veteran: true, inactive: true, freshBlood: true , hotStreak: true)])
    }
    
    func leagueTierBySummonerID(summonerID: String) async -> Result<LeagueTier?, NetworkError> {
        return .success(LeagueTier(tier: Tier.diamond, rank: Rank.i, points: 25))
    }
    
    
}
