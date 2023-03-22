//
//  RecordStrategy.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/02/27.
//

import Foundation

protocol RecordStrategy {
    func predicate(championName: String) -> NSPredicate
    func toDictionary(matches: [Match]) -> [String: [Int]]
    func convertToChampionWithRate(matches: [Match]) -> [ChampionWithRate]
}
