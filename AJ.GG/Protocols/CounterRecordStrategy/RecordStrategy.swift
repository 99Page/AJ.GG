//
//  RecordStrategy.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/02/27.
//

import Foundation

protocol RecordStrategy {
    func sort(matches: [Match]) -> [ChampionWithRate]
    func predicate(championName: String) -> NSPredicate
}
