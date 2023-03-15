//
//  CounterRecordContext.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/02/27.
//

import Foundation

struct CounterRecordContext {
    var strategy: RecordStrategy
    
    func sort(matches: [Match]) -> [ChampionWithRate] {
        strategy.sort(matches: matches)
    }
    
    func predicate(championName: String) -> NSPredicate {
        strategy.predicate(championName: championName)
    }
}
