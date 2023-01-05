//
//  EntitiesEntexsion.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/02.
//

import Foundation

extension Summoner {
    
    convenience init(id: String, puuid: String, summonerName: String, tier: String, rank: String) {
        self.init
    }
    
    func to(summoner: Summoner) {
        self.tier = summoner.tier
        self.id = summoner.id
        self.summonerName = summoner.summonerName
        self.puuid = summoner.puuid
        self.rank = summoner.rank
    }
}
