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
    @Published var matches: [Match] = []
    
    init(matchV5Service: MatchV5ServiceEnable) {
        self.summonerManager = SummonerManager()
        self.matchManager = MatchManager()
        self.summoners = summonerManager.getAll()
        self.matchV5Service = matchV5Service
        
        Task {
            await fetchMatches()
            getRecentMatch()
        }
    }
    
    func getRecentMatch() {
        Task {
            if let puuid = summoners.first?.puuid {
                print("puuid : \(puuid)")
                let matchDTOs = await matchV5Service.searchMatchDTOsByPuuid(puuid: puuid)
                switch matchDTOs {
                case .success(let success):
                    success.forEach { matchDTO in
                        matchManager.save(matchDTO: matchDTO, puuid: puuid)
                    }
                    
                    await fetchMatches()
                case .failure(_):
                    break
                }
            }
        }
    }
    
    @MainActor
    func fetchMatches() async {
        self.matches = matchManager.getAll()
    }
    
    
}
