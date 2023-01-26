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
    private let matchV5Service: MatchV5ServiceEnable
    
    var searchedSummoner: SummonerDTO?
    @Published var summonerName: String = ""
    @Published var tier: LeagueTier?
    @Published var summoners: [Summoner] = []
    @Published private var _matches: [MatchDTO] = []
    
    var matches: [MatchDTO] {
        _matches
    }
    
    var matchesIndices: Range<Int> {
        summoners.indices
    }
    
    init(summonerService: SummonerServiceEnable, leagueV4Service: LeagueV4ServiceEnable, matchV5Service: MatchV5ServiceEnable) {
        self.summonerService = summonerService
        self.leagueV4Service = leagueV4Service
        self.summonerManager = SummonerManager()
        self.summoners = summonerManager.getAll()
        self.matchV5Service = matchV5Service
    }
    
    @MainActor
    func buttonTapped() async {
        do {
            self._matches.removeAll()
            let summonerResult = await summonerService.summonerByName(summonerName: self.summonerName)
            let summoner = try summonerResult.get()
            self.searchedSummoner = summoner
            
            
            let matchIDsResult = await matchV5Service.matcheIDsByPuuid(puuid: summoner.puuid)
            switch matchIDsResult {
            case .success(let matchIds):
                let matcheDTOsResult = await matchV5Service.searchMatchDTOsByMatchIDs(matchIDs: matchIds)
                
                switch matcheDTOsResult {
                case .success(let success):
                    self._matches = success
                case .failure(let failure):
                    throw failure
                }
            case .failure(let failure):
                throw failure
            }
        } catch {

        }
    }
}

