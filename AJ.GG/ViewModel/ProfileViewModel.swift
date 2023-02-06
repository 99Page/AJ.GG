//
//  HomeViewModel.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/02.
//

import Foundation


class ProfileViewModel: ObservableObject {
    
    
    let matchV5Service: MatchV5ServiceEnable
    
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
            result.append(ChampionWithRate(champion: Champion(name: k), win: array[0], lose: array[1]))
        }
        
        return result.sorted()
    }
    
    var rivalChampionRecords: [ChampionWithRate] {
        var dictionary: [String: [Int]] = [:]
        
        for match in filterdMatchsByLane {
            if dictionary[match.rivalChampionName] == nil {
                dictionary[match.rivalChampionName] = [0, 0]
            }
            
            if match.isWin {
                dictionary[match.rivalChampionName]![0] += 1
            } else {
                dictionary[match.rivalChampionName]![1] += 1
            }
        }
        
        var result: [ChampionWithRate] = []
        
        for (k, v) in dictionary {
            let array = v
            result.append(ChampionWithRate(champion: Champion(name: k), win: array[0], lose: array[1]))
        }
        
        return result.sorted().reversed()
    }
 
    
    init(summonerManager: SummonerManager, matchManager: MatchManager, matchV5Service: MatchV5ServiceEnable) {
        self.summonerManager = summonerManager
        self.matchManager = matchManager
        self.matchV5Service = matchV5Service
        
        let fetchedSummoners = summonerManager.getAll()
        self.summoners = fetchedSummoners
        self.selectedSummoner = fetchedSummoners[0]
        
        self.matches = matchManager.getAll()
        
        Task {
            await fetchRecentMatces(fetchedSummoners[0].puuid)
        }
    }
    
    @MainActor
    private func fetchRecentMatces(_ puuid: String) async {
        Task {
            let matchesResult = await matchV5Service.searchMatchDTOsByPuuid(puuid: puuid)
            
            switch matchesResult {
            case .success(let success):
                for data in success {
                    let dict = DictionaryController.match(match: Match(data, puuid: puuid))
                    matchManager.add(dict)
                }
                
            case .failure(let failure):
                print("\(failure)")
            }
        }
    }
}
