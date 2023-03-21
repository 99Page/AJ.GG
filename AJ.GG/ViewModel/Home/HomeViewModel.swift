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
    
    @Published private(set) var summoners: [Summoner] = []
    @Published private(set) var matches: [Match] = []
    @Published private(set) var selectedLane: Lane = .top
    @Published var isSummonerEmpty: Bool = false
    
    var matchesByLane: [Match] {
        return matches.filter {
            $0.isEqualLane(selectedLane)
        }
    }
    
    
    init(matchV5Serivce: MatchV5ServiceEnabled, containerSoruce: PersistentContainerSource) {
        self.matchV5Service = MatchV5ServiceInjector.select(service: matchV5Serivce)
        self.summonerManager = CDSummonerManager(container: PersistentContainerInjector.select(source: containerSoruce))
        self.matchManager = CDMatchManager(container: PersistentContainerInjector.select(source: containerSoruce))
        
        fetchAndStore()
    }
    
    private func fetchAndStore()  {
        fetchSummoners()
    }
    
    private func fetchSummoners() {
        let summonerEntities = summonerManager.fetchAll()
        self.summoners = summonerEntities.map { Summoner(cdSummoner: $0)}
        
        if summoners.isEmpty {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.isSummonerEmpty = true
            }
        } else {
            for summonerEntity in summonerEntities {
                Task {
                    await fetchMatchesBySummoner(summonerEntity: summonerEntity)
                    await addMatches(summonerEntity: summonerEntity)
                    await fetchMatchesBySummoner(summonerEntity: summonerEntity)
                }
            }
        }
    }
    
    @MainActor
    private func fetchMatchesBySummoner(summonerEntity: CDSummoner) {
        let fetchedMatches = matchManager.fetchBySummoner(sumonerEntity: summonerEntity).map { Match($0) }
        
        self.matches = fetchedMatches
    }
    
    private func addMatches(summonerEntity: CDSummoner) async {
        let summoner = Summoner(cdSummoner: summonerEntity)
        
        switch await matchV5Service.searchMatchDTOsWhereRankGameByPuuid(puuid: summoner.puuid) {
        case .success(let values):
            for value in values {
                matchManager.add(summonerEntity: summonerEntity,
                                 match: Match(value, puuid: summoner.puuid))
            }
        case .failure(_):
            break
        }
    }
    
    func laneButtonTapped(_ lane: Lane) {
        self.selectedLane = lane
    }
}
