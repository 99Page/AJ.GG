//
//  Summoner.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/31.
//

import Foundation

struct Summoner: DummyCreatable, Identifiable, Equatable {
    
    typealias Dummy = Summoner
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.summonerID == rhs.summonerID && lhs.puuid == rhs.puuid &&
        lhs.summonerName == rhs.summonerName && lhs.profileIconID == rhs.profileIconID
    }
    
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
    
    init(cdSummoner: CDSummoner) {
        self.summonerID = cdSummoner.id ?? "-1"
        self.puuid = cdSummoner.puuid ?? "-1"
        self.summonerName = cdSummoner.summonerName ?? "에러"
        self.profileIconID = cdSummoner.profileIconID 
    }
    
    init(_ summonerDTO: SummonerDTO) {
        self.summonerID = summonerDTO.id
        self.puuid = summonerDTO.puuid
        self.summonerName = summonerDTO.name
        self.profileIconID = Int16(summonerDTO.profileIconID)
    }
    
    static func dummyTopmMatch() -> Summoner {
        return  Summoner(summonerID: "jU2mjgEFQ0ly_fqZliKMNUhNwrFeAaV4Fq1YSTjQD5kXCPk", puuid: "123", summonerName: "SwiftUI", profileIconID: 685)
    }
    
    static func dummyDatas() -> [Summoner] {
        return [
            Summoner(summonerID: "", puuid: "", summonerName: "SwiftUI", profileIconID: 686),
//            Summoner(summonerID: "", puuid: "", summonerName: "SwiftUI 2", profileIconID: 687),
            Summoner(summonerID: "", puuid: "", summonerName: "SwiftUI 3", profileIconID: 688)
        ]
    }
}
