//
//  HomeViewModel.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/02.
//

import Foundation
import CoreData


class ProfileViewModel: ObservableObject {
    
    
    let matchV5Service: MatchV5ServiceEnable
    let summonerManager: DataManager<CDSummoner>
    let matchManager: DataManager<CDMatch>
    
    @Published var summoners: [Summoner] = []
    @Published var selectedSummoner: Summoner

    @Published var selectedLane: Lane = .top
    @Published var matches: [Match] = []

    
    @Published var itemsDisappear: Bool = true
    @Published var counterRecordStrategy: RecordStrategy = MyRecordStrategy()
    
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


    init(matchV5Service: MatchV5ServiceEnable,
         matchManager: DataManager<CDMatch>,
         summonerManager: DataManager<CDSummoner>) {
        
        self.matchV5Service = matchV5Service
        self.matchManager = matchManager
        self.summonerManager = summonerManager
        
        let fetchedSummoners = summonerManager.fetchEntites().map {  Summoner(cdSummoner: $0) }
        self.summoners = fetchedSummoners
        
        if fetchedSummoners.count > 0 {
            self.selectedSummoner = fetchedSummoners[0]
        } else {
            self.selectedSummoner = Summoner.dummyData()
        }
//
//
        Task {
            await fetchMatches()
            await saveRecentRankMatches(selectedSummoner.puuid)
            print("ProfileViewInit Ended")
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
        let matchesResult = await matchV5Service.searchMatchDTOsWhereRankGameByMatchIDs(matchIDs: ids)
        switch matchesResult {
        case .success(let matches):
            for match in matches {
                if !self.matches.contains(where: { $0.containMatchID(match.matchID())}) && match.isRankGame {
                    print("\(match.matchID())")
                    let predicate = NSPredicate(format: "id == %@", selectedSummoner.summonerID)
                    if let summoner = summonerManager.fetchEntites(predicate: predicate, sortDescriptor: nil).first {
                        let matchEntity = matchManager.create()
                        matchEntity.update(match: match, summonerEntity: summoner, puuid: puuid)
                        matchManager.save()
                    }
                }
            }

        case .failure(let failure):
            print("\(failure)")
        }

        await fetchMatches()
        print("\(self.matches.count)")
    }

    @MainActor
    private func fetchMatches() async {
        self.matches.removeAll()
        self.itemsDisappear = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) {
            let summonerPredicate = NSPredicate(format: "id == %@", self.selectedSummoner.summonerID)
            
            let summoners: [CDSummoner]  = self.summonerManager.fetchEntites(predicate: summonerPredicate)

            if let summoner = summoners.first {
                let predicate = NSPredicate(format: "%K == %@", #keyPath(CDMatch.playedBy), summoner)
                self.matches = self.matchManager.fetchEntites(predicate: predicate).map({ Match($0) })
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
