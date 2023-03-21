//
//  RegisterSummonerViewModel.swift
//  AJ.GG
//
//  Created by 노우영 on 2022/12/26.
//

import Foundation
import CoreData
import SwiftUI

class SummonerRegistrationViewModel: ObservableObject {
    @Published var summonerName: String = ""
    
    @Published private(set) var summoner: Summoner?
    @Published private(set) var leagueTier: LeagueTier?
    @Published private(set) var matches: [Match] = []
    
    @Published private(set) var isSearchOngoing: Bool = false
    
    @Published var isPresented: Bool = false
    @Published var isPresentedAddSummonerAlert: Bool = false
    @Published var goToNextView: Bool = false
    
    let title = "소환사 이름을 입력해주세요."
    private let summonerService: SummonerServiceEnabled
    private let leagueV4Service: LeagueV4ServiceEnabled
    private let matchV5Service: MatchV5ServiceEnabled
    private let summonerManager: CDSummonerManager
    
    init(summonerService: SummonerServiceEnabled, leagueV4Service: LeagueV4ServiceEnabled,
         matchV5Service: MatchV5ServiceEnabled, container: PersistentContainerSource) {
        self.summonerService = SummonerServiceInjector.select(service: summonerService)
        self.leagueV4Service = LeagueV4ServiceInjector.select(service: leagueV4Service)
        self.matchV5Service = MatchV5ServiceInjector.select(service: matchV5Service)
        self.summonerManager = CDSummonerManager(container: PersistentContainerInjector.select(source: container))
    }
    
    
    @MainActor
    func searchButtonTapped() async {
        isSearchOngoing = true
        
        guard !summonerName.isEmpty else {
            isPresented = true
            clear()
            return
        }
        
        switch await summonerService.summonerByName(summonerName: summonerName) {
        case .success(let value):
            self.summoner = Summoner(value)
            goToNextView = true
        case .failure(_):
            handleFailure()
            return
        }
        
        if let summoner = summoner {
            switch await leagueV4Service.leagueTierBySummonerID(summonerID: summoner.summonerID) {
            case .success(let value):
                self.leagueTier = value
            case .failure(_):
                handleFailure()
                return
            }
            
            switch await matchV5Service.searchMatchDTOsWhereRankGameByPuuid(puuid: summoner.puuid) {
            case .success(let value):
                self.matches = value.map { Match($0, puuid: summoner.puuid) }
            case .failure(_):
                handleFailure()
                return
            }
        }
        
        isSearchOngoing = false
    }
    
    func handleFailure() {
        self.isPresented = true
        self.isSearchOngoing = false
    }

    func clear() {
        summoner = nil
        leagueTier = nil 
        matches = []
        summonerName = "" 
    }
    
    func addSummoner() {
        if let summoner = self.summoner, let leagueTier = self.leagueTier {
            summonerManager.addSummoner(summoner: summoner, leagueTier: leagueTier)
        }
    }
}
