//
//  HomeViewModel.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/02.
//

import Foundation
import CoreData


class HomeViewModel: ObservableObject {
    let matchV5Service: MatchV5ServiceEnabled
    let summonerManager: CDSummonerManager
    let matchManager: CDMatchManager
    
    @Published var summoners: [Summoner] = []
    @Published var matches: [Match] = []
    @Published var isSummonerEmpty: Bool = false
    
    init(matchV5Serivce: MatchV5ServiceEnabled, containerSoruce: PersistentContainerSource) {
        self.matchV5Service = MatchV5ServiceInjector.select(service: matchV5Serivce)
        self.summonerManager = CDSummonerManager(container: PersistentContainerInjector.select(source: containerSoruce))
        self.matchManager = CDMatchManager(container: PersistentContainerInjector.select(source: containerSoruce))
        
        fetchStoredEntities()
    }
    
    private func fetchStoredEntities() {
        fetchSummoners()
    }
    
    private func fetchSummoners() {
        print("fetchSummoner call!")
        let summonerEntities = summonerManager.fetchAll()
        self.summoners = summonerEntities.map { Summoner(cdSummoner: $0)}
        
        if summoners.isEmpty {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.isSummonerEmpty = true
            }
        } else {
            for summonerEntity in summonerEntities {
                fetchMatchesBySummoner(summonerEntity: summonerEntity)
            }
        }
    }
    
    private func fetchMatchesBySummoner(summonerEntity: CDSummoner) {
        let fetchedMatches = matchManager.fetchBySummoner(sumonerEntity: summonerEntity).map { Match($0) }
        
        self.matches.append(contentsOf: fetchedMatches)
    }
}
