//
//  HomeViewModel.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/02.
//

import Foundation


class ProfileViewModel: ObservableObject {
    
    let summonerManager: SummonerManager
    let matchManager: MatchManager
    let matchV5Service: MatchV5ServiceEnable
    
    @Published var summoners: [Summoner] = []
    @Published var matches: [CDMatch] = []
    
    init(matchV5Service: MatchV5ServiceEnable) {
        self.summonerManager = SummonerManager()
        self.matchManager = MatchManager()
        self.summoners = summonerManager.getAll()
        self.matchV5Service = matchV5Service
    }
}
