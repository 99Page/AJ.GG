//
//  ChampionRecordViewModel.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/02/07.
//

import Foundation
import CoreData

class ChampionRecordViewModel: ObservableObject {
    
    let champion: Champion
    let matchManager: DataManager<CDMatch>
    let isMyChampion: Bool
    
    @Published var matches: [Match] = []
    
    var championWithRates: [ChampionWithRate] {
        var dictionary: [String: [Int]] = [:] 
        
        for match in matches {
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
        
        return result
    }
    
    var myChampionWithRates: [ChampionWithRate] {
        var dictionary: [String: [Int]] = [:]
        
        for match in matches {
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
        
        return result
    }
    
    var rates: [ChampionWithRate] {
        if self.isMyChampion {
            return championWithRates
        } else {
            return myChampionWithRates
        }
    }
   
    var championName: String {
        self.champion.name
    }
    
    init(champion: Champion, matchManager: DataManager<CDMatch>, isMyChampion: Bool) {
        self.champion = champion
        self.matchManager = matchManager
        self.isMyChampion = isMyChampion
        self.fetchEntities()
    }
    
    private func fetchEntities() {
        var predicate: NSPredicate
        
        if isMyChampion {
            predicate = NSPredicate(format: "%K == %@", #keyPath(CDMatch.myChampionID), champion.name)
            print("My Champion")
        } else {
            predicate = NSPredicate(format: "%K == %@", #keyPath(CDMatch.enemyChampionID), champion.name)
        }
        
        self.matches = matchManager.fetchEntites(predicate: predicate).map({ Match($0) })
    }
}
