//
//  LeagueV4Service.swift
//  AJ.GG
//
//  Created by 노우영 on 2022/12/29.
//

import Foundation
import Alamofire

protocol LeagueV4ServiceEnabled: ServiceProtocol {
    func leagueTierBySummonerID(summonerID: String) async -> Result<LeagueTier?, NetworkError>
}

class LeagueV4Serivce: RiotAuthorizaiton, LeagueV4ServiceEnabled {
    
    func leagueTierBySummonerID(summonerID: String) async -> Result<LeagueTier?, NetworkError> {
        
        let url = "\(RIOT_API_URL)/lol/league/v4/entries/by-summoner/\(summonerID)"
        let response = await AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).serializingDecodable(LeagueEntryDTOs.self).response
        
        let result = response.result
        
        return result
            .map { if let first = $0.first {
                    let tier = LeagueTier(tier: Tier(rawValue: first.tier),
                                          rank: Rank(rawValue: first.rank),
                                          points: Int32(first.leaguePoints))
                    return tier
                } else {
                    return nil
                }
            }
            .mapError { err in
            let serverError = response.data.flatMap { try? JSONDecoder().decode(ServerError.self, from: $0) }
            return NetworkError(AFError: err, serverError: serverError)
        }
    }
}

class MockLeagueV4ServiceSuccess: LeagueV4ServiceEnabled {
    func leagueTierBySummonerID(summonerID: String) async -> Result<LeagueTier?, NetworkError> {
        return .success(LeagueTier(tier: Tier.diamond, rank: Rank.i, points: 25))
    }
}

class MockLeagueV4ServiceFailure: LeagueV4ServiceEnabled {
    func leagueTierBySummonerID(summonerID: String) async -> Result<LeagueTier?, NetworkError> {
        let status: ServerDecoding = ServerDecoding(message: "Data not found", statusCode: 404)
        let serverError: ServerError = ServerError(status: status)
        return .failure(NetworkError(AFError: nil, serverError: serverError)) 
    }
}
