//
//  MatchFIlter.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/04/17.
//

import Foundation

protocol MatchFilter {
    var matches: [Match] { get set }
}

struct OriginalMatches: MatchFilter {
    var matches: [Match]
}
