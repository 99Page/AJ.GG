//
//  SummonerRecordViewModel.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/04/12.
//

import Foundation
import SwiftUI

class SummonerRecordViewModel: ObservableObject {
    
    let summoner: Summoner

    @Published private(set) var leagueTier: LeagueTier?
    @Published private(set) var matches: [Match] = []
    
    @Published private(set) var isSearchOngoing: Bool = false
    @Published var isPresentedAddSummonerAlert: Bool = false
    @Published var isPresnetedDeleteSummoerAlert: Bool = false
    var registeredSummoner: [Summoner] = []
    
    private let summonerService: SummonerServiceEnabled
    private let leagueV4Service: LeagueV4ServiceEnabled
    private let matchV5Service: MatchV5ServiceEnabled
    private let summonerManager: CDSummonerManager
    
    var isRegisterd: Bool {
        registeredSummoner.contains {
            $0.summonerName == summoner.summonerName
        }
    }
    
    init(summoner: Summoner, summonerService: SummonerServiceEnabled, leagueV4Service: LeagueV4ServiceEnabled,
         matchV5Service: MatchV5ServiceEnabled, container: PersistentContainerSource) {
        self.summoner = summoner
        self.summonerService = SummonerServiceInjector.select(service: summonerService)
        self.leagueV4Service = LeagueV4ServiceInjector.select(service: leagueV4Service)
        self.matchV5Service = MatchV5ServiceInjector.select(service: matchV5Service)
        self.summonerManager = CDSummonerManager(container: PersistentContainerInjector.select(source: container))
        self.fetchSummoners()
        
        Task {
            await searchButtonTapped()
        }
    }
    
    
    @MainActor
    func searchButtonTapped() async {
        switch await leagueV4Service.leagueTierBySummonerID(summonerID: summoner.summonerID) {
        case .success(let value):
            self.leagueTier = value
        case .failure(_):
            handleFailure()
            return
        }

        switch await matchV5Service.searchMatchDTOsWhereRankGameByPuuid(puuid: summoner.puuid) {
        case .success(let value):
            self.matches = value.filter{
                $0.isRankGame
            }.map {
                Match($0, puuid: summoner.puuid)
            }
        case .failure(_):
            handleFailure()
            return
        }

        isSearchOngoing = false
    }
    
    func handleFailure() {
        self.isSearchOngoing = false
    }


    fileprivate func addSummoner() {
        if let leagueTier = self.leagueTier {
            summonerManager.addSummoner(summoner: summoner, leagueTier: leagueTier)
        }
    }

    func deleteSummoner() {
        summonerManager.deleteAll()
    }

    func registerSummoner() {
        deleteSummoner()
        addSummoner()
        fetchSummoners()
    }
    
    func fetchSummoners() {
        self.registeredSummoner = summonerManager.fetchAll().map {
            Summoner(cdSummoner: $0)
        }
    }
    
    func deleteAlertTapped() {
        deleteSummoner()
        fetchSummoners()
    }
    
    @MainActor
    func filledStarTapped() {
        print("Fileld Start Tapped!")
        self.isPresnetedDeleteSummoerAlert = true
    }
    
    @MainActor
    func emptyStarTapped() {
        self.isPresentedAddSummonerAlert = true 
    }
}
