//
//  EntitiesEntexsion.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/02.
//

import Foundation
import CoreData

extension Summoner {
    
    convenience init(summonerDTO: SummonerDTO, leagueTier: LeagueTier?, context: NSManagedObjectContext) {
        self.init(context: context)
        self.id = summonerDTO.id
        self.puuid = summonerDTO.puuid
        self.summonerName = summonerDTO.name
        self.tier = leagueTier?.tier?.rawValue
        self.rank = leagueTier?.rank?.rawValue
        self.leaguePoints = leagueTier?.points ?? 0
    }
    
    func setSummoner(summonerDTO: SummonerDTO, leagueTier: LeagueTier?) {
        self.id = summonerDTO.id
        self.puuid = summonerDTO.puuid
        self.summonerName = summonerDTO.name
        self.tier = leagueTier?.tier?.rawValue
        self.rank = leagueTier?.rank?.rawValue
        self.leaguePoints = leagueTier?.points ?? 0
    }
}
