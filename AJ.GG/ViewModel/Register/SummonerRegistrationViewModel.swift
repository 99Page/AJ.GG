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
    
    let title = "소환사의 이름을 입력해주세요."
    private let summonerService: SummonerServiceEnabled
    private let leagueV4Service: LeagueV4ServiceEnabled
    
    init(summonerService: SummonerServiceEnabled, leagueV4Service: LeagueV4ServiceEnabled) {
        self.summonerService = summonerService
        self.leagueV4Service = leagueV4Service
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
            return
        }
        
        if let summoner = summoner {
            switch await leagueV4Service.leagueTierBySummonerID(summonerID: summoner.summonerID) {
            case .success(let value):
                self.leagueTier = value
            case .failure(_):
                return
            }
        }
    }

    private func clear() {
        summoner = nil
        matches = []
    }
}
