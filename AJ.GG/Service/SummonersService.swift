//
//  SummonersService.swift
//  AJ.GG
//
//  Created by 노우영 on 2022/12/26.
//

import Foundation
import Alamofire

protocol SummonerServiceEnable {
    func summonerByName(summonerName: String) async -> Result<SummonerDTO, NetworkError>
    func idByName(summonerName: String) async -> Result<String, NetworkError>
}

class SummonerService: SummonerServiceEnable {
    
    func summonerByName(summonerName: String) async -> Result<SummonerDTO, NetworkError> {
        
        let url = "https://KR.api.riotgames.com/lol/summoner/v4/summoners/by-name/\(summonerName)"
        let encoded = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
        let encodedURL = URL(string: encoded)!
        
        let headers: HTTPHeaders = [
            AUTH_KEY : RIOT_API_KEY
        ]
        
        let response = await AF.request(encodedURL, method: .get, encoding: JSONEncoding.default, headers: headers).serializingDecodable(SummonerDTO.self).response
        
        if response.error != nil {
            print(response.debugDescription)
        }
        
        let result = response.result
        
        return result.mapError { err in
            let serverError = response.data.flatMap { try? JSONDecoder().decode(ServerError.self, from: $0) }
            return NetworkError(AFError: err, status: serverError)
        }
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
