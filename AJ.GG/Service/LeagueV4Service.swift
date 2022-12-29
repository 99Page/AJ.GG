//
//  LeagueV4Service.swift
//  AJ.GG
//
//  Created by 노우영 on 2022/12/29.
//

import Foundation
import Alamofire

protocol LeagueV4ServiceEnable {
    func leaguesBySummonerID(summonerID: String) async -> DataResponse<LeagueEntryDTOs, NetworkError>
}

class LeagueV4Serivce: RiotAuthorizaiton, LeagueV4ServiceEnable {
    
    func leaguesBySummonerID(summonerID: String) async -> Alamofire.DataResponse<LeagueEntryDTOs, NetworkError> {
        
        let url = "\(RIOT_API_URL)/lol/league/v4/entries/by-summoner/\(summonerID)"
        let response = await AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).serializingDecodable(LeagueEntryDTOs.self).response
        
        return response.mapError { err in
            let serverError = response.data.flatMap { try? JSONDecoder().decode(ServerError.self, from: $0) }
            return NetworkError(AFError: err, status: serverError)
        }
    }
    
    
}
