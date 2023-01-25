//
//  Summoner + Extension.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/24.
//

import Foundation
import CoreData

extension Summoner: Copyable {
    func copy(_ origin: Summoner) {
        self.id = origin.id
        self.puuid = origin.puuid
        self.summonerName = origin.summonerName
        self.tier = origin.tier
        self.rank = origin.rank
        self.leaguePoints = origin.leaguePoints
    }
    
    typealias Data = Summoner
    
    
}

extension Summoner {
    convenience init(summonerDTO: SummonerDTO, leagueTier: LeagueTier?) {
        self.init()
        self.puuid = summonerDTO.puuid
        self.summonerName = summonerDTO.name
        self.tier = leagueTier?.tier?.rawValue
        self.rank = leagueTier?.rank?.rawValue
        self.leaguePoints = leagueTier?.points ?? 0
        self.id = summonerDTO.id
    }
}
