//
//  MatchV5Service.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/10.
//

import Foundation
import Alamofire

protocol MatchV5ServiceEnabled: ServiceProtocol {
    func searchMatchDTOsWhereRankGameByPuuid(puuid: String) async -> Result<[MatchDTO], NetworkError>
}

class MatchV5Service: RiotAuthorizaiton, MatchV5ServiceEnabled {
    private func matchByMatchID(matchID: String) async -> Result<MatchDTO, NetworkError> {
        
        let url = "\(url(region: .asia))/lol/match/v5/matches/\(matchID)"
        let response = await AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).serializingDecodable(MatchDTO.self).response
        
        if response.error != nil {
            print(response.debugDescription)
        }
        
        let result = response.result
        return result.mapError { err in
            let serverError = response.data.flatMap { try? JSONDecoder().decode(ServerError.self, from: $0) }
            return NetworkError(AFError: err, serverError: serverError)
        }
    }
    
    private func matcheIDsByPuuid(puuid: String) async -> Result<[String], NetworkError> {
        
        let url = "\(url(region: .asia))/lol/match/v5/matches/by-puuid/\(puuid)/ids"
        
        let response = await AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).serializingDecodable(Strings.self).response
        
        if response.error != nil {
            print(response.debugDescription)
        }
        
        let result = response.result
        return result.mapError { err in
            let serverError = response.data.flatMap { try? JSONDecoder().decode(ServerError.self, from: $0) }
            return NetworkError(AFError: err, serverError: serverError)
        }
    }
    
    private func searchMatchDTOsWhereRankGameByMatchIDs(matchIDs: [String]) async -> Result<[MatchDTO], NetworkError> {
        var matchDTOs: [MatchDTO] = []
        
        for matchID in matchIDs {
            let matchResult = await self.matchByMatchID(matchID: matchID)
            switch matchResult {
            case .success(let success):
                matchDTOs.append(success)
            case .failure(let failure):
                return .failure(failure)
            }
        }
        
        return .success(matchDTOs)
    }
    
    
    func searchMatchDTOsWhereRankGameByPuuid(puuid: String) async -> Result<[MatchDTO], NetworkError> {
        let idsResult = await self.matcheIDsByPuuid(puuid: puuid)

        switch idsResult {
        case .success(let ids):
            return await searchMatchDTOsWhereRankGameByMatchIDs(matchIDs: ids)
        case .failure(let failure):
            return .failure(failure)
        }
    }
}

class MockMatchV5ServiceSuccess: MatchV5ServiceEnabled {
    func searchMatchDTOsWhereRankGameByPuuid(puuid: String) async -> Result<[MatchDTO], NetworkError> {
        let decoder = JSONDecoder()
        
        do {
            do { sleep(3) }
            var result: [MatchDTO] = []
            for data in MATCH_DATA {
                result.append(try! decoder.decode(MatchDTO.self, from: data))
            }
            return .success(result)
        }
    }
}

class MockMatchV5ServiceFailure: MatchV5ServiceEnabled {
    func searchMatchDTOsWhereRankGameByPuuid(puuid: String) async -> Result<[MatchDTO], NetworkError> {
        let status: ServerDecoding = ServerDecoding(message: "Data not found", statusCode: 404)
        let serverError: ServerError = ServerError(status: status)
        return .failure(NetworkError(AFError: nil, serverError: serverError))
    }
}
