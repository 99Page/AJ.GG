//
//  MyChampionFilterStrategy.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/03/29.
//

import Foundation

struct MyChampionFilterStrategy: MatchFilterStrategy {
    func filter(matches: [Match], champion: Champion) -> [Match] {
        return matches.filter {
            $0.myChampionName == champion.name
        }
    }
}
