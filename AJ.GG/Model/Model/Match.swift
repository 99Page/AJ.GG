//
//  Match.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/25.
//

import Foundation

struct Match: Identifiable, DummyCreatable {
    static func dummyData() -> Match {
        return Match(mySummonerName: "SwiftUI", myChampion: Champion(name: "Aatrox"), myKDA: [10, 2, 3], rivalChampion: Champion(name: "Garen"), rivalSummonerName: "Faker", rivalKDA: [1, 5, 2], isWin: true)
    }
    
    static func dummyDatas() -> [Match] {
        return [
            Match(mySummonerName: "SwiftUI", myChampion: Champion(name: "Aatrox"), myKDA: [10, 2, 3], rivalChampion: Champion(name: "Garen"), rivalSummonerName: "Faker", rivalKDA: [1, 5, 2], isWin: true),
            Match(mySummonerName: "SwiftUI", myChampion: Champion(name: "Aatrox"), myKDA: [10, 2, 3], rivalChampion: Champion(name: "Garen"), rivalSummonerName: "Faker", rivalKDA: [1, 5, 2], isWin: false),
            Match(mySummonerName: "SwiftUI", myChampion: Champion(name: "Aatrox"), myKDA: [10, 2, 3], rivalChampion: Champion(name: "Garen"), rivalSummonerName: "Faker", rivalKDA: [1, 5, 2], isWin: true)
        ]
    }
    
    typealias Dummy = Match
    
    
    let id = UUID().uuidString
    let mySummonerName: String
    let myChampion: Champion
    let myKDA: [Int16]
    
    let rivalChampion: Champion
    let rivalSummonerName: String
    let rivalKDA: [Int16]
    
    let isWin: Bool
    
    init(mySummonerName: String, myChampion: Champion, myKDA: [Int16], rivalChampion: Champion, rivalSummonerName: String, rivalKDA: [Int16], isWin: Bool) {
        self.mySummonerName = mySummonerName
        self.myChampion = myChampion
        self.myKDA = myKDA
        self.rivalChampion = rivalChampion
        self.rivalSummonerName = rivalSummonerName
        self.rivalKDA = rivalKDA
        self.isWin = isWin
    }
    
    init(_ match: CDMatch) {
        self.myChampion = Champion(name: match.myChampionID ?? Champion.optionalCase().name)
        self.mySummonerName = match.mySummonerName ?? "에러"
        self.myKDA = [match.myKill, match.myDeath, match.myAssist]
        
        self.rivalChampion = Champion(name: match.myChampionID ?? Champion.optionalCase().name)
        self.rivalSummonerName = match.rivalSummonerName ?? "에러"
        self.rivalKDA = [match.rivalKill, match.rivalDeath, match.rivalAssist]
        
        self.isWin = match.isWin
    }
    
    init(_ match: MatchDTO, puuid: String) {
        
        self.myChampion = match.myChampionByPuuid(puuid)
        self.mySummonerName = match.rivalSummonerNameByPuuid(puuid)
        self.myKDA = match.myKDAByPuuid(puuid).map { Int16($0) }
        
        self.rivalChampion = match.rivalChampionByPuuid(puuid)
        self.rivalSummonerName = match.rivalSummonerNameByPuuid(puuid)
        self.rivalKDA = match.rivalKDAByPuuid(puuid).map { Int16($0) }
        
        self.isWin = match.isWinByPuuid(puuid)
    }
}
