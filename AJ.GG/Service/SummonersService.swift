//
//  SummonersService.swift
//  AJ.GG
//
//  Created by 노우영 on 2022/12/26.
//

import Foundation
import Alamofire

protocol SummonerServiceEnabled {
    func summonerByName(summonerName: String) async -> Result<SummonerDTO, NetworkError>
    func idByName(summonerName: String) async -> Result<String, NetworkError>
}

class SummonerService: RiotAuthorizaiton, SummonerServiceEnabled {
    
    func summonerByName(summonerName: String) async -> Result<SummonerDTO, NetworkError> {
        
        let url = "https://KR.api.riotgames.com/lol/summoner/v4/summoners/by-name/\(summonerName)"
        let encoded = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
        let encodedURL = URL(string: encoded)!
//
//        let response1 = await AF.request(encodedURL, method: .get, encoding: JSONEncoding.default, headers: headers).serializingString().response
//
//        switch response1.result{
//        case .success(let value):
//            print("value: \(value)")
//        case .failure(let err):
//            print("\(err.errorDescription)")
//        }
//
        
        let response = await AF.request(encodedURL, method: .get, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .serializingDecodable(SummonerDTO.self).response
        
        
        return response.mapError { err in
            let serverError = response.data.flatMap { try? JSONDecoder().decode(ServerError.self, from: $0) }
            return NetworkError(AFError: err, serverError: serverError)
        }.result
    }
    
    func idByName(summonerName: String) async -> Result<String, NetworkError> {
        let response = await self.summonerByName(summonerName: summonerName)
        
        switch response {
        case .success(let value):
            return .success(value.id)
        case .failure(let err):
            return .failure(err)
        }
    }
    
    
}

class MockSummonerSerivceSuccess: SummonerServiceEnabled {
    
    func summonerByName(summonerName: String) async -> Result<SummonerDTO, NetworkError> {
        let summonerDTO = SummonerDTO(id: "1234", accountID: "1234", puuid: "1234", name: summonerName
                                      , profileIconID: 1, revisionDate: 1, summonerLevel: 1)
        
        return .success(summonerDTO)
    }
    
    func idByName(summonerName: String) async -> Result<String, NetworkError> {
        return .success("SwiftUI")
    }
}

class MockSummonerServiceFailure: SummonerServiceEnabled {
    func summonerByName(summonerName: String) async -> Result<SummonerDTO, NetworkError> {
        let status: ServerDecoding = ServerDecoding(message: "Data not found", statusCode: 404)
        let serverError: ServerError = ServerError(status: status)
        return .failure(NetworkError(AFError: nil, serverError: serverError))
    }
    
    func idByName(summonerName: String) async -> Result<String, NetworkError> {
        let status: ServerDecoding = ServerDecoding(message: "Data not found", statusCode: 404)
        let serverError: ServerError = ServerError(status: status)
        return .failure(NetworkError(AFError: nil, serverError: serverError)) 
    }
}
