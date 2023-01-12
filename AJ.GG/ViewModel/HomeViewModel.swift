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
    @Published var matchs: [Match] = []
    
    init(matchV5Service: MatchV5ServiceEnable) {
        self.summonerManager = SummonerManager()
        self.matchManager = MatchManager()
        
        self.summoners = summonerManager.getAll()
        self.matchV5Service = matchV5Service
        
        getRecentMatch()
        let matchs = matchManager.getAll()
        print("match count : \(matchs.count)")
    }
    
    func getRecentMatch() {
        Task {
            let matchDTOs = await matchV5Service.searchMatchDTOsByPuuid(puuid: summoners[0].puuid!)
            switch matchDTOs {
            case .success(let success):
                success.forEach { matchDTO in
                    matchManager.save(matchDTO: matchDTO, puuid: summoners[0].puuid!)
                }
            case .failure(_):
                break
            }
        }
    }
    
    
    
}
