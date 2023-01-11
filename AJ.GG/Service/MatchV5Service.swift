//
//  MatchV5Service.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/10.
//

import Foundation
import Alamofire

protocol MatchV5ServiceEnable {
    func matcheIDsByPuuid(puuid: String) async -> Result<Strings, NetworkError>
    func matchByMatchID(matchID: String) async -> Result<MatchDTO, NetworkError>
    func searchMatch(puuid: String) async
}

class MatchV5Service: RiotAuthorizaiton, MatchV5ServiceEnable {
    func matchByMatchID(matchID: String) async -> Result<MatchDTO, NetworkError> {
        
        let url = "\(url(region: .asia))/lol/match/v5/matches/\(matchID)"
        let response = await AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).serializingDecodable(MatchDTO.self).response
        
        if response.error != nil {
            print(response.debugDescription)
        }
        
        let result = response.result
        return result.mapError { err in
            let serverError = response.data.flatMap { try? JSONDecoder().decode(ServerError.self, from: $0) }
            return NetworkError(AFError: err, status: serverError)
        }
    }
    
    func matcheIDsByPuuid(puuid: String) async -> Result<Strings, NetworkError> {
        
        let url = "\(url(region: .asia))/lol/match/v5/matches/by-puuid/\(puuid)/ids"
        
        let response = await AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).serializingDecodable(Strings.self).response
        
        if response.error != nil {
            print(response.debugDescription)
        }
        
        let result = response.result
        return result.mapError { err in
            let serverError = response.data.flatMap { try? JSONDecoder().decode(ServerError.self, from: $0) }
            return NetworkError(AFError: err, status: serverError)
        }
    }
    
    func searchMatch(puuid: String) async {
        do {
            print("searchMatch called")
            let idsResult = await self.matcheIDsByPuuid(puuid: puuid)
            let ids = try idsResult.get()
            let matchResult = await self.matchByMatchID(matchID: ids[0])
            let match = try matchResult.get()
            print(match)
        } catch {
            
        }
    }
}

