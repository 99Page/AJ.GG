//
//  RivalCounterReordStrategy.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/02/27.
//

import Foundation

struct RivalCounterRecordStrategy: RecordStrategy {
    
    func predicate(championName: String) -> NSPredicate {
        NSPredicate(format: "%K == %@", #keyPath(CDMatch.enemyChampionID), championName)
    }
    
    func toDictionary(matches: [Match]) -> [String : [Int]] {
        var result: [String: [Int]] = [:]
        
        for match in matches {
            if result[match.myChampionName] == nil  {
                result[match.myChampionName] = [0, 0]
            }
            
            if match.isWin {
                result[match.myChampionName]![0] += 1
            } else {
                result[match.myChampionName]![1] += 1
            }
        }
        
        return result
    }
    
    func convertToChampionWithRate(matches: [Match]) -> [ChampionWithRate] {
        let dictionary = toDictionary(matches: matches)
        var result: [ChampionWithRate] = []
        for (k, v) in dictionary {
            let array = v
            result.append(ChampionWithRate(champion: Champion(name: k), win: array[0], lose: array[1]))
        }
        return result.sorted()
    }
}
