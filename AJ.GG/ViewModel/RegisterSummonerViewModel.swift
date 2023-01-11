//
//  RegisterSummonerViewModel.swift
//  AJ.GG
//
//  Created by 노우영 on 2022/12/26.
//

import Foundation
import CoreData

@MainActor
class RegisterSummonerViewModel: ObservableObject {
    
    let title = "소환사 이름을 입력해주세요."
    private let summonerManager: SummonerManager
    private let summonerService: SummonerServiceEnable
    private let leagueV4Service: LeagueV4ServiceEnable
    
    @Published var summonerName: String = ""
    @Published var tier: LeagueTier?
    @Published var summoners: [Summoner] = []
    
    var isSummonerRegistered: Bool {
        !summoners.isEmpty
    }
  
    
    init(summonerService: SummonerServiceEnable, leagueV4Service: LeagueV4ServiceEnable) {
        self.summonerService = summonerService
        self.leagueV4Service = leagueV4Service
        self.summonerManager = SummonerManager()
        self.summoners = summonerManager.getAll()
    }
    
    @MainActor
    func buttonTapped() async {
        do {
            let summonerResult = await summonerService.summonerByName(summonerName: self.summonerName)
            let summoner = try summonerResult.get()
            let tierResult = await leagueV4Service.leagueTierBySummonerID(summonerID: summoner.id)
            let tier = try tierResult.get()
            self.tier = tier
            self.summonerManager.save(summonerDTO: summoner, tier: tier)
            self.summoners = summonerManager.getAll()
        } catch {
            
        }
    }

    func deleteSummonersAll() {
        summonerManager.deleteAll()
    }
}

