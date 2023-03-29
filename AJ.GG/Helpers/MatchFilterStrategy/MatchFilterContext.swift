//
//  MatchFilterContext.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/03/29.
//

import Foundation

struct MatchFilterContext {
    var strategy: MatchFilterStrategy
    
    func execute(matches: [Match], champion: Champion) -> [Match] {
        let result = strategy.filter(matches: matches, champion: champion)
        return result 
    }
}
