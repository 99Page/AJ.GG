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
        
        var id = ""
        
        switch await searchSummonerIdByName() {
        case .success(let value):
            id = value
        case .failure(let error):
            print("\(error.localizedDescription)")
            return
        }
    }
    
    private func searchSummonerIdByName() async -> Result<String, NetworkError> {
        return await self.summonerService.idByName(summonerName: summonerName)
    }
    
    private func clear() {
        summoner = nil
        matches = []
    }
}
