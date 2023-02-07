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
    
    @Published var summoners: [Summoner] = []
    @Published var selectedSummoner: Summoner
    
    @Published var selectedLane: Lane = .mid
    @Published var matches: [Match] = []
    
    @Published var selectedChampion: Champion?
    
    var filterdMatchsByLane: [Match] {
        matches.filter { $0.lane == selectedLane }
    }
    
    var myChampionWithRates: [ChampionWithRate] {
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
    
    var rivalChampionWithRates: [ChampionWithRate] {
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
        
        let fetchedSummoners = summonerManager.fetchAll()
        self.summoners = fetchedSummoners
        self.selectedSummoner = fetchedSummoners[0]
        
        
        Task {
            await fetchMatchesAll()
            await fetchRecentMatces(fetchedSummoners[0].puuid)
        }
    }
//    
    @MainActor
    private func fetchRecentMatces(_ puuid: String) async {
        Task {
            let matcheIDsResult = await matchV5Service.matcheIDsByPuuid(puuid: puuid)
            switch matcheIDsResult {
            case .success(let ids):
                await handleMatchIds(ids, puuid: puuid)
            case .failure(let failure):
                print("\(failure)")
            }
        }
    }
    
    private func handleMatchIds(_ ids: [String], puuid: String) async {
        for id in ids {
            if !matches.contains(where: { $0.containMatchID(id)}) {
                let matchDtoResult = await matchV5Service.matchByMatchID(matchID: id)
                switch matchDtoResult {
                case .success(let success):
                    let dict = DictionaryController.match(match: Match(success, puuid: puuid))
                    matchManager.add(dict)
                    await fetchMatchesAll()
                case .failure(let failure):
                    print("\(failure)")
                }
            }
        }
    }
    
    @MainActor
    private func fetchMatchesAll() {
        self.matches = matchManager.fetchAll()
    }
}
