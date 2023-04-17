//
//  MatchFilterDecorator.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/04/17.
//

import Foundation

protocol MatchFilterDecorator: MatchFilter {
    var delegate: MatchFilter { get set }
}
