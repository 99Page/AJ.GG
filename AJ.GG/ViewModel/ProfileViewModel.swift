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
    
    @Published var selectedLane: Lane = .mid
    @Published var matches: [Match] = []
    
    var filterdMatchsByLane: [Match] {
        matches.filter { $0.lane == selectedLane }
    }
    
    var myChampionRecords: [ChampionWithRate] {
        var dictionary: [String: [Int]] = [:]
        
        for match in filterdMatchsByLane {
            if dictionary[match.myChampionName] == nil {
                dictionary[match.myChampionName] = [0, 0]
            }
            
            if match.isWin {
                dictionary[match.myChampionName]![0] += 1
            } else {
                dictionary[match.myChampionName]![1] += 1
            }
        }
        
        var result: [ChampionWithRate] = []
        
        for (k, v) in dictionary {
            let array = v
            let win = array[0]
            let total = array[0] + array[1]
            result.append(ChampionWithRate(champion: Champion(name: k), win: array[0], lose: array[1]))
        }
        
        return result
    }
    
//    var rivalChampionRecords: [ChampionWithRate] {
//        var dictionary: [String: [Int]] = [:]
//
//        for match in filterdMatchsByLane {
//            if dictionary[match.rivalChampion] == nil {
//                dictionary[match.myChampionName] = [0, 0]
//            }
//
//            if match.isWin {
//                dictionary[match.myChampionName]![0] += 1
//            } else {
//                dictionary[match.myChampionName]![1] += 1
//            }
//        }
//
//        var result: [ChampionWithRate] = []
//
//        for (k, v) in dictionary {
//            let array = v
//            let win = array[0]
//            let total = array[0] + array[1]
//            result.append(ChampionWithRate(champion: Champion(name: k), win: array[0], lose: array[1]))
//        }
//
//        return result
//    }
    
    init(summonerManager: SummonerManager, matchManager: MatchManager) {
        self.summonerManager = summonerManager
        self.matchManager = matchManager
        
        let fetchedSummoners = summonerManager.getAll()
        self.summoners = fetchedSummoners
        self.selectedSummoner = fetchedSummoners[0]
        
        self.matches = matchManager.getAll()
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
