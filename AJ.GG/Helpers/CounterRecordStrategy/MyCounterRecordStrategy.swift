//
//  MyRecordStrategy.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/02/27.
//

import Foundation

struct MyCounterRecordStrategy: RecordStrategy {
    
    func winRate() -> Bool {
        return false
    }
    
    func title(champion: Champion) -> String {
        return "\(champion.name) 상대하기 어려운 챔피언"
    }
    
    
    func toDictionary(matches: [Match]) -> [String : [Int]] {
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
        
        return dictionary
    }
    
    func predicate(championName: String) -> NSPredicate {
        NSPredicate(format: "%K == %@", #keyPath(CDMatch.myChampionID), championName)
    }
    
    func convertToChampionWithRate(matches: [Match]) -> [ChampionWithRate] {
        let dictionary = toDictionary(matches: matches)
        var result: [ChampionWithRate] = []
        for (k, v) in dictionary {
            let array = v
            result.append(ChampionWithRate(champion: Champion(name: k), win: array[0], lose: array[1]))
        }
        return result.sorted().reversed()
    }
}
