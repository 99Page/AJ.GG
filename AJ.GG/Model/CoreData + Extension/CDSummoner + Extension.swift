//
//  Summoner + Extension.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/24.
//

import Foundation
import CoreData

//extension CDSummoner: Copyable {
//    func copy(_ origin: Summoner) {
//        self.id = origin.id
//        self.puuid = origin.puuid
//        self.summonerName = origin.sumomonerName
//        self.tier = origin.tier
//        self.rank = origin.rank
//        self.leaguePoints = origin.leaguePoints
//    }
//
//    typealias Data = Summoner
//
//
//}

extension CDSummoner: AllSettable {
    func setValues(_ data: [String: Any]) {
        self.setValue(data["puuid"], forKey: "puuid")
        self.setValue(data["id"], forKey: "id")
        self.setValue(data["summonerName"], forKey: "summonerName")
        self.setValue(data["tier"], forKey: "tier")
        self.setValue(data["rank"], forKey: "rank")
        self.setValue(data["leaguePoints"], forKey: "leaguePoints")
        self.setValue(data["profileIconID"], forKey: "profileIconID")
    }
    
    func update(summoner: SummonerDTO, tier: LeagueTier) {
        self.tier = tier.tier?.rawValue
        self.puuid = summoner.puuid
        self.summonerName = summoner.name
        self.id = summoner.id
        self.leaguePoints = tier.points
        self.profileIconID = Int16(summoner.profileIconID)
        self.rank = tier.rank?.rawValue
    }
}
