//
//  HomeViewModel.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/02.
//

import Foundation

class ProfileViewModel: ObservableObject {
    
    let summonerManager: SummonerManager
    let matchV5Service: MatchV5ServiceEnable
    @Published var summoners: [Summoner] = []
    
    init(matchV5Service: MatchV5ServiceEnable) {
        self.summonerManager = SummonerManager()
        self.summoners = summonerManager.getAll()
        self.matchV5Service = matchV5Service
        
        getRecentMatch()
    }
    
    func getRecentMatch() {
        Task {
            print("getRecentMatch called")
            await matchV5Service.searchMatch(puuid: summoners[0].puuid!)
        }
    }
    
    
    
}
