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
        strategy.convertToChampionWithRate(matches: matches)
    }
    
    func title(champion: Champion) -> String {
        return strategy.title(champion: champion)
    }
    
    var winRate: Bool {
        strategy.winRate()
    }
}
