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
    
    @Published var showSuccessToast: Bool = false
    @Published var showFailureToast: Bool = false
    
    var matchesByLane: [Match] {
        return matches.filter {
            $0.isEqualLane(selectedLane)
        }
    }
    
    var rivalCount: [ChampionWithRate] {
        let strategy = RivalCounterRecordStrategy()
        return strategy.convertToChampionWithRate(matches: matchesByLane)
    }
    
    var myCounter: [ChampionWithRate] {
        let strategy = MyCounterRecordStrategy()
        return strategy.convertToChampionWithRate(matches: matchesByLane)
    }
    
    init(matchV5Serivce: MatchV5ServiceEnabled, containerSoruce: PersistentContainerSource) {
        self.matchV5Service = MatchV5ServiceInjector.select(service: matchV5Serivce)
        self.summonerManager = CDSummonerManager(container: PersistentContainerInjector.select(source: containerSoruce))
        self.matchManager = CDMatchManager(container: PersistentContainerInjector.select(source: containerSoruce))
        
        fetchAndStore()
    }
    
    func fetchAndStore()  {
        fetchSummoners()
    }
    
    private func fetchSummoners() {
        let summonerEntities = summonerManager.fetchAll()
        self.summoners = summonerEntities.map { Summoner(cdSummoner: $0)}
        print("\(summoners)")
        
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
    
    @MainActor
    fileprivate func handleSuccessToast() {
        self.showSuccessToast = true
        
        Task {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.showSuccessToast = false
            }
        }
    }
    
    @MainActor
    fileprivate func addMatches(_ values: ([MatchDTO]),
                                _ summonerEntity: CDSummoner, _ summoner: Summoner) {
        
        for value in values {
            matchManager.add(summonerEntity: summonerEntity,
                             match: Match(value, puuid: summoner.puuid))
        }
        
        handleSuccessToast()
    }
    
    
    
    private func addMatches(summonerEntity: CDSummoner) async {
        let summoner = Summoner(cdSummoner: summonerEntity)
        
        switch await matchV5Service.searchMatchDTOsWhereRankGameByPuuid(puuid: summoner.puuid) {
        case .success(let values):
            let actual = values.filter {
                $0.isRankGame
            }
            await addMatches(actual, summonerEntity, summoner)
        case .failure(_):
            break
        }
    }
    
    func laneButtonTapped(_ lane: Lane) {
        self.selectedLane = lane
    }
}
