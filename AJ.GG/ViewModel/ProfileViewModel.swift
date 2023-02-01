//
//  HomeViewModel.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/02.
//

import Foundation


class ProfileViewModel: ObservableObject {
    
    let summonerManager: SummonerManager
    let matchManager: MatchManager
    let matchV5Service: MatchV5ServiceEnable
    
    @Published var summoners: [CDSummoner] = []
    @Published var selectedSummoner: CDSummoner
    @Published var matches: [CDMatch] = []
    
    init(matchV5Service: MatchV5ServiceEnable) {
        self.summonerManager = SummonerManager()
        self.matchManager = MatchManager()
        self.matchV5Service = matchV5Service
        
        let fetchedSummoners = summonerManager.getAll()
        self.summoners = fetchedSummoners
        self.selectedSummoner = fetchedSummoners[0]
    }
    
    private func saveMatches() async {
        for summoner in summoners {
            let matchResult = await matchV5Service.searchMatchDTOsByPuuid(puuid: summoner.puuid ?? "-1")
            
            switch matchResult {
            case .success(let matchDTOs):
                handleMatchDTOs(matchDTOs: matchDTOs, summoner: summoner)
            case .failure(_):
                break
            }
            
        }
    }
    
    private func handleMatchDTOs(matchDTOs: [MatchDTO], summoner: CDSummoner) {
        for matchDTO in matchDTOs {
            let data: [String: Any] = [
                "enemyChampionID": matchDTO.rivalChampionByPuuid(summoner.puuid ?? "-1").name,
                "gameCreation" : matchDTO.gameCreation,
                "id" : matchDTO.matchID(),
                "isWin" : matchDTO.isWinByPuuid(summoner.puuid ?? "-1"),
                "lane" : matchDTO.getLaneByPuuid(summoner.puuid ?? "-1")?.rawValue ?? "TOP",
                "myChampionID": matchDTO.myChampionByPuuid(summoner.puuid ?? "-1").name,
                "version": matchDTO.version(),
                "playedBy": summoner
            ]

            matchManager.add(data)
        }
    }
}
