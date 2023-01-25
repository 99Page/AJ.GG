//
//  RegisterSummonerViewModel.swift
//  AJ.GG
//
//  Created by 노우영 on 2022/12/26.
//

import Foundation
import CoreData
import SwiftUI

class RegisterSummonerViewModel: ObservableObject {
    
    let _title = "소환사 이름을 입력해주세요."
    private let summonerManager: SummonerManager
    private let summonerService: SummonerServiceEnable
    private let leagueV4Service: LeagueV4ServiceEnable
    
    @Published var summonerName: String = ""
    @Published var tier: LeagueTier?
    @Published var summoners: [Summoner] = []
    
    init(summonerService: SummonerServiceEnable, leagueV4Service: LeagueV4ServiceEnable) {
        self.summonerService = summonerService
        self.leagueV4Service = leagueV4Service
        self.summonerManager = SummonerManager()
        self.summoners = summonerManager.getAll()
    }
    
    @MainActor
    func buttonTapped() async {
        print(_summonerName)
//        do {
//            let summonerResult = await summonerService.summonerByName(summonerName: self._summonerName)
//            let summoner = try summonerResult.get()
//            let tierResult = await leagueV4Service.leagueTierBySummonerID(summonerID: summoner.id)
//            let tier = try tierResult.get()
//            self._tier = tier
//            let summonerData = Summoner(summonerDTO: summoner, leagueTier: tier)
//            self.summonerManager.add(summonerData)
//            self._summoners = summonerManager.getAll()
//        } catch {
//
//        }
    }

    func deleteSummonersAll() {
        summonerManager.deleteAll()
    }
}

