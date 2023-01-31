//
//  Summoner.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/31.
//

import Foundation

struct Summoner: DummyCreatable, Identifiable {
    
    static func dummyData() -> Summoner {
        return  Summoner(summonerID: "", puuid: "", summonerName: "SwiftUI")
    }
    
    static func dummyDatas() -> [Summoner] {
        return [
            Summoner(summonerID: "", puuid: "", summonerName: "SwiftUI"),
            Summoner(summonerID: "", puuid: "", summonerName: "SwiftUI 2"),
            Summoner(summonerID: "", puuid: "", summonerName: "SwiftUI 3")
        ]
    }
    
    typealias Dummy = Summoner
    
    let id = UUID().uuidString
    let summonerID: String
    let puuid: String
    let summonerName: String
    
    init(summonerID: String, puuid: String, summonerName: String) {
        self.summonerID = summonerID
        self.puuid = puuid
        self.summonerName = summonerName
    }
    
    init(_ summonerDTO: SummonerDTO) {
        self.summonerID = summonerDTO.id
        self.puuid = summonerDTO.puuid
        self.summonerName = summonerDTO.name
    }
}
