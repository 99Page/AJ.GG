//
//  RivalChampionFilterStrategy.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/03/29.
//

import Foundation

struct RivalChampionFilterStrategy: MatchFilterStrategy {
    func filter(matches: [Match], champion: Champion) -> [Match] {
        return matches.filter {
            $0.rivalChampionName == champion.name
        }
    }
}
