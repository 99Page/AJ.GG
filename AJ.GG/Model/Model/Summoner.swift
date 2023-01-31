//
//  Summoner.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/31.
//

import Foundation

struct Summoner: DummyCreatable, Identifiable {
    
    static func dummyData() -> Summoner {
        return  Summoner(summonerID: "", puuid: "", summonerName: "SwiftUI", profileIconID: 685)
    }
    
    static func dummyDatas() -> [Summoner] {
        return [
            Summoner(summonerID: "", puuid: "", summonerName: "SwiftUI", profileIconID: 686),
//            Summoner(summonerID: "", puuid: "", summonerName: "SwiftUI 2", profileIconID: 687),
            Summoner(summonerID: "", puuid: "", summonerName: "SwiftUI 3", profileIconID: 688)
        ]
    }
    
    typealias Dummy = Summoner
    
    let id = UUID().uuidString
    let summonerID: String
    let puuid: String
    let summonerName: String
    let profileIconID: Int16
    
    init(summonerID: String, puuid: String, summonerName: String, profileIconID: Int16) {
        self.summonerID = summonerID
        self.puuid = puuid
        self.summonerName = summonerName
        self.profileIconID = profileIconID
    }
    
    init(_ summonerDTO: SummonerDTO) {
        self.summonerID = summonerDTO.id
        self.puuid = summonerDTO.puuid
        self.summonerName = summonerDTO.name
        self.profileIconID = Int16(summonerDTO.profileIconID)
    }
}
