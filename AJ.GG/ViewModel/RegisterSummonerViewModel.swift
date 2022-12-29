//
//  RegisterSummonerViewModel.swift
//  AJ.GG
//
//  Created by 노우영 on 2022/12/26.
//

import Foundation

class RegisterSummonerViewModel: ObservableObject {
    
    let title = "소환사 이름을 입력해주세요."
    
    @Published var summonerName: String = ""
    @Published var tier: Tier?
    
    private let summonerService: SummonerServiceEnable
    private let leagueV4Service: LeagueV4ServiceEnable
    
    init(summonerService: SummonerServiceEnable, leagueV4Service: LeagueV4ServiceEnable) {
        self.summonerService = summonerService
        self.leagueV4Service = leagueV4Service
    }
    
    var isNameEmpty: Bool {
        summonerName.isEmpty
    }
    
    @MainActor
    func buttonTapped() async {
        
        let response = await summonerService.summonerByName(summonerName: self.summonerName)
        
        if response.error != nil {
            return
        } else if let id = response.value?.id  {
            let response2 = await leagueV4Service.leaguesBySummonerID(summonerID: id)
            if let value = response2.value {
                for t in Tier.allCases {
                    if t.rawValue == value.first?.tier {
                        self.tier = t
                    }
                }
            }
        }
    }
    
}
