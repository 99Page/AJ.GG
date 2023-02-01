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
//    let matchV5Service: MatchV5ServiceEnable
//
    @Published var summoners: [Summoner] = []
    @Published var selectedSummoner: Summoner
//    @Published var matches: [Match] = []
//    @Published var selectedLane: Lane = .top
//
//    var fileterdMatches: [Match] {
//        let result =  matches.filter { $0.isEqualLane(selectedLane) }
//        return result
//    }
    
    init(summonerManager: SummonerManager) {
        self.summonerManager = summonerManager
        self.matchManager = MatchManager()
        let fetchedSummoners = summonerManager.getAll()
        self.summoners = fetchedSummoners
        self.selectedSummoner = fetchedSummoners[0]
    }
//    init(matchV5Service: MatchV5ServiceEnable) {
//        self.summonerManager = SummonerManager()
//        self.matchManager = MatchManager()
//        self.matchV5Service = matchV5Service
//        

//        self.summoners = fetchedSummoners
//        self.selectedSummoner = fetchedSummoners[0]
//    }
//    
//    private func saveMatches() async {
//        for summoner in summoners {
//            let matchResult = await matchV5Service.searchMatchDTOsByPuuid(puuid: summoner.puuid )
//            
//            switch matchResult {
//            case .success(let matchDTOs):
//                handleMatchDTOs(matchDTOs: matchDTOs, summoner: summoner)
//            case .failure(_):
//                break
//            }
//            
//        }
//    }
//    
//    private func handleMatchDTOs(matchDTOs: [MatchDTO], summoner: Summoner) {
//        for matchDTO in matchDTOs {
//            let data: [String: Any] = [
//                "enemyChampionID": matchDTO.rivalChampionByPuuid(summoner.puuid ).name,
//                "gameCreation" : matchDTO.gameCreation,
//                "id" : matchDTO.matchID(),
//                "isWin" : matchDTO.isWinByPuuid(summoner.puuid ),
//                "lane" : matchDTO.laneByPuuid(summoner.puuid ).rawValue ,
//                "myChampionID": matchDTO.myChampionByPuuid(summoner.puuid ).name,
//                "version": matchDTO.version(),
//                "playedBy": summoner
//            ]
//
//            matchManager.add(data)
//        }
//    }
}
