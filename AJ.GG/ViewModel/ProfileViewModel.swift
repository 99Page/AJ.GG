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
//
    @Published var summoners: [Summoner] = []
    @Published var selectedSummoner: Summoner

    @Published var selectedLane: Lane = .top
    @Published var matches: [Match] = []

    
    @Published var itemsDisappear: Bool = true
    
    var matchesByLane: [Match] {
        matches.filter { $0.lane == selectedLane }
    }

    var myChampionWithRates: [ChampionWithRate] {
        var dictionary: [String: [Int]] = [:]

        for match in matchesByLane {
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

        for match in matchesByLane {
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

    var isMatchEmpty: Bool {
        self.matchesByLane.isEmpty
    }


    init(summonerManager: SummonerManager, matchManager: MatchManager, matchV5Service: MatchV5ServiceEnable) {
        print("ProfileViewModel init")
        self.summonerManager = summonerManager
        self.matchManager = matchManager
        self.matchV5Service = matchV5Service

        let fetchedSummoners = summonerManager.fetchAll()
        self.summoners = fetchedSummoners
        self.selectedSummoner = fetchedSummoners[0]
//
//
        Task {
            await fetchMatches()
            await saveRecentRankMatches(fetchedSummoners[0].puuid)
        }
    }
    
    @MainActor
    private func saveRecentRankMatches(_ puuid: String) async {
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
        let matchesResult = await matchV5Service.searchMatchDTOsByMatchIDs(matchIDs: ids)
    
        switch matchesResult {
        case .success(let matches):
            for match in matches {
                if !self.matches.contains(where: { $0.containMatchID(match.matchID())}) {
                    let predicate = NSPredicate(format: "id == %@", selectedSummoner.summonerID)
                    if let summoner = summonerManager.fetchEntites(predicate: predicate, sortDescriptor: nil).first {
                        let dict = DictionaryController.match(match: Match(match, puuid: puuid), summoner: summoner)
                        matchManager.add(dict)
                    }
                }
            }

        case .failure(let failure):
            print("\(failure)")
        }

        await fetchMatches()
    }

    @MainActor
    private func fetchMatches() async {
        self.matches.removeAll()
        self.itemsDisappear = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) {
            let summonerPredicate = NSPredicate(format: "id == %@", self.selectedSummoner.summonerID)
            let summoners: [CDSummoner]  = self.summonerManager.fetchEntites(predicate: summonerPredicate, sortDescriptor: nil)

            if let summoner = summoners.first {
                let predicate = NSPredicate(format: "%K == %@", #keyPath(CDMatch.playedBy), summoner)
                self.matches = self.matchManager.fetchDatas(predicate: predicate)
            }
            
            self.itemsDisappear = false
        }
    }

    @MainActor
    func laneButtonTapped(_ lane: Lane) {
        self.selectedLane = lane
        self.itemsDisappear = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) {
            self.itemsDisappear = false
        }
    }
}
