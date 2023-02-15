//
//  RegisterSummonerViewModel.swift
//  AJ.GG
//
//  Created by 노우영 on 2022/12/26.
//

import Foundation
import CoreData
import SwiftUI

class RegisterSummonerViewModel: ObservableObject, ServiceAlertEnable {
    
    func showAlert(_ error: NetworkError) {
        if error.statusCode == 404 {
            alert.titleString = "소환사를 찾을 수 없습니다."
            alert.messageString = "소환사명을 확인해주세요."
            alert.isPresentedAlert = true
        }
    }
    
    
    let _title = "소환사 이름을 입력해주세요."
    private let summonerManager: SummonerManager
    private let summonerService: SummonerServiceEnable
    private let leagueV4Service: LeagueV4ServiceEnable
    private let matchV5Service: MatchV5ServiceEnable
    
    var searchedSummoner: SummonerDTO?
    
    @Published var summonerName: String = ""
    
    @Published var alert = CustomAlert()
    @Published var tier: LeagueTier?
    @Published var summoners: [Summoner] = []
    @Published private var _matches: [Match] = []
    
    @Published var isSearching = false
    
    
    init(summonerService: SummonerServiceEnable, leagueV4Service: LeagueV4ServiceEnable,
         matchV5Service: MatchV5ServiceEnable, summonerManager: SummonerManager = SummonerManager()) {
        self.summonerService = summonerService
        self.leagueV4Service = leagueV4Service
        self.matchV5Service = matchV5Service
        self.summonerManager = summonerManager
        self.summonerManager.deleteAll()
        self.summoners = summonerManager.fetchAll()
    }
    
    
    var isPresentedAlert: Bool {
        alert.isPresentedAlert
    }
    
    var isRegistered: Bool {
        !summoners.isEmpty
    }
    
    var matches: [Match] {
        _matches
    }
    
    var matchesIndices: Range<Int> {
        summoners.indices
    }
    
    var emblemImage: Image {
        self.tier?.emblemImage ?? Tier.bronze.emblemImage
    }
    
    var isSearched: Bool {
        searchedSummoner != nil 
    }

    private func clear() {
        self._matches.removeAll()
        self.tier = nil
        self.searchedSummoner = nil
    }
    
    @MainActor
    func buttonTapped() async {
        do {
            self.isSearching = true
            clear()
            
            let summonerResult = await summonerService.summonerByName(summonerName: self.summonerName)
      
            let summoner = try summonerResult.get()
            self.searchedSummoner = summoner
            
            let leagueResult = await leagueV4Service.leagueTierBySummonerID(summonerID: summoner.id)
            self.tier = try leagueResult.get()


            let matchIDsResult = await matchV5Service.matcheIDsByPuuid(puuid: summoner.puuid)
            switch matchIDsResult {
            case .success(let matchIds):
                let matcheDTOsResult = await matchV5Service.searchMatchDTOsWhereRankGameByMatchIDs(matchIDs: matchIds)

                switch matcheDTOsResult {
                case .success(let success):
                    self._matches = success.map { Match($0, puuid: summoner.puuid)}
                case .failure(let failure):
                    throw failure
                }
            case .failure(let failure):
                throw failure
            }
            self.isSearching = false
        } catch {
            self.isSearching = false
            self.showAlert(error as! NetworkError)
        }
    }
    
    func registerButtonTapped() {
        
        if let summoner = self.searchedSummoner, let tier = self.tier {
            
            let data: [String: Any] = [
                "id" : summoner.id,
                "puuid" : summoner.puuid,
                "leaguePoints" : tier.points,
                "summonerName" : summoner.name,
                "rank" : tier.rank?.rawValue ?? "I",
                "tier" : tier.tier?.rawValue ?? "IRON",
                "profileIconID" : summoner.profileIconID
            ]
            
            self.summonerManager.add(data)
        }
    }
    
    func fetchSummonersAll() {
        self.summoners = summonerManager.fetchAll()
    }
    
    func deleteSummonersAll() {
        self.summonerManager.deleteAll()
    }
}
