//
//  Match.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/25.
//

import Foundation

struct Match: Identifiable, DummyCreatable {
    static func dummyData() -> Match {
        return Match(mySummonerName: "SwiftUI", myChampion: Champion(name: "Aatrox"), myKDA: [10, 2, 3], rivalChampion: Champion(name: "Garen"), rivalSummonerName: "Faker", rivalKDA: [1, 5, 2], isWin: true, lane: .top)
    }
    
    static func dummyDatas() -> [Match] {
        return [
            Match(mySummonerName: "SwiftUI", myChampion: Champion(name: "Aatrox"), myKDA: [10, 2, 3], rivalChampion: Champion(name: "Garen"), rivalSummonerName: "Faker", rivalKDA: [1, 5, 2], isWin: true, lane: .top),
            Match(mySummonerName: "SwiftUI", myChampion: Champion(name: "Aatrox"), myKDA: [10, 2, 3], rivalChampion: Champion(name: "Garen"), rivalSummonerName: "Faker", rivalKDA: [1, 5, 2], isWin: false, lane: .top),
            Match(mySummonerName: "SwiftUI", myChampion: Champion(name: "Aatrox"), myKDA: [10, 2, 3], rivalChampion: Champion(name: "Garen"), rivalSummonerName: "Faker", rivalKDA: [1, 5, 2], isWin: true, lane: .top)
        ]
    }
    
    typealias Dummy = Match
    
    
    let id = UUID().uuidString
    let mySummonerName: String
    let _myChampion: Champion
    let myKDA: [Int16]
    
    let rivalChampion: Champion
    let rivalSummonerName: String
    let rivalKDA: [Int16]
    
    let isWin: Bool
    let lane: Lane
    
    var myChampionName: String {
        _myChampion.name
    }
    
    func isEqualLane(_ lane: Lane) -> Bool {
        return lane.isEqual(lane)
    }
    
    init(mySummonerName: String, myChampion: Champion, myKDA: [Int16], rivalChampion: Champion, rivalSummonerName: String, rivalKDA: [Int16], isWin: Bool, lane: Lane) {
        self.mySummonerName = mySummonerName
        self._myChampion = myChampion
        self.myKDA = myKDA
        self.rivalChampion = rivalChampion
        self.rivalSummonerName = rivalSummonerName
        self.rivalKDA = rivalKDA
        self.isWin = isWin
        self.lane = lane
    }
    
    init(_ match: CDMatch) {
        self._myChampion = Champion(name: match.myChampionID ?? Champion.optionalCase().name)
        self.mySummonerName = match.mySummonerName ?? "에러"
        self.myKDA = [match.myKill, match.myDeath, match.myAssist]
        
        self.rivalChampion = Champion(name: match.myChampionID ?? Champion.optionalCase().name)
        self.rivalSummonerName = match.rivalSummonerName ?? "에러"
        self.rivalKDA = [match.rivalKill, match.rivalDeath, match.rivalAssist]
        
        self.isWin = match.isWin
        self.lane = Lane(rawValue: match.lane ?? "Invalid") ?? .invalid
    }
    
    init(_ match: MatchDTO, puuid: String) {
        
        self._myChampion = match.myChampionByPuuid(puuid)
        self.mySummonerName = match.rivalSummonerNameByPuuid(puuid)
        self.myKDA = match.myKDAByPuuid(puuid).map { Int16($0) }
        
        self.rivalChampion = match.rivalChampionByPuuid(puuid)
        self.rivalSummonerName = match.rivalSummonerNameByPuuid(puuid)
        self.rivalKDA = match.rivalKDAByPuuid(puuid).map { Int16($0) }
        
        self.isWin = match.isWinByPuuid(puuid)
        self.lane = match.laneByPuuid(puuid)
    }
}
