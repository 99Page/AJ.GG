//
//  MatchFilterStrategy.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/03/29.
//

import Foundation

protocol MatchFilterStrategy {
    func filter(matches: [Match], champion: Champion) -> [Match]
}
