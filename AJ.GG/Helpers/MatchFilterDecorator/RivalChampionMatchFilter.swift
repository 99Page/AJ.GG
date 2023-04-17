//
//  RivalChampionMatchFilter.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/04/17.
//

import Foundation


struct RivalChampionMatchFilter: MatchFilterDecorator {
    var delegate: MatchFilter
    
    var matches: [Match]
    
    init(delegate: MatchFilter, champion: Champion) {
        self.delegate = delegate
        
        self.matches = delegate.matches.filter {
            $0.rivalChampion.name == champion.name
        }
    }
}
