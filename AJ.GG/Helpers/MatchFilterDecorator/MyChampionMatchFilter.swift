//
//  MyChampionMatchFilter.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/04/17.
//

import Foundation

struct MyChampionMatchFilter: MatchFilterDecorator {
    var delegate: MatchFilter
    
    var matches: [Match]
    
    init(delegate: MatchFilter, champion: Champion) {
        self.delegate = delegate
        
        self.matches = delegate.matches.filter {
            $0._myChampion.name == champion.name
        }
    }
}
