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
    
    @Published var summoner: Summoner?
    @Published var leagueTier: LeagueTier? 
    @Published var matches: [Match] = []
    
    @Published var isPresented: Bool = false
    
    let title = "소환사 이름을 입력해주세요."
    private let summonerService: SummonerServiceEnabled
    private let leagueV4Service: LeagueV4ServiceEnabled
    private let matchV5Service: MatchV5ServiceEnabled
    
    init(summonerService: SummonerServiceEnabled, leagueV4Service: LeagueV4ServiceEnabled,
         matchV5Service: MatchV5ServiceEnabled) {
        self.summonerService = SummonerServiceInjector.select(service: summonerService)
        self.leagueV4Service = leagueV4Service
        self.matchV5Service = matchV5Service
    }
    
    
    func searchButtonTapped() async {
        guard !summonerName.isEmpty else {
            clear()
            return
        }
        
        switch await summonerService.summonerByName(summonerName: summonerName) {
        case .success(let value):
            self.summoner = Summoner(value)
        case .failure(_):
            isPresented = true 
            return
        }
        
        if let summoner = summoner {
            switch await leagueV4Service.leagueTierBySummonerID(summonerID: summoner.summonerID) {
            case .success(let value):
                self.leagueTier = value
            case .failure(_):
                return
            }
            
            switch await matchV5Service.searchMatchDTOsWhereRankGameByPuuid(puuid: summoner.puuid) {
            case .success(let value):
                self.matches = value.map { Match($0, puuid: summoner.puuid) }
            case .failure(_):
                return
            }
        }
    }

    private func clear() {
        summoner = nil
        leagueTier = nil 
        matches = []
    }
}
