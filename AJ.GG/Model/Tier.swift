//
//  Tier.swift
//  AJ.GG
//
//  Created by 노우영 on 2022/12/29.
//

import Foundation
import SwiftUI

enum Tier: String, CaseIterable{
    case iron = "IRON"
    case bronze = "BRONZE"
    case silver = "SILVER"
    case gold = "GOLD"
    case platinum = "PLATINUM"
    case diamond = "DIAMOND"
    case master = "MASTER"
    case grandmaster = "GRANDMASTER"
    case challenger = "CHALLENGER"
    
    var emblem: String {
        switch self {
            
        case .iron:
            return "Emblem_Iron"
        case .bronze:
            return "Emblem_Bronze"
        case .silver:
            return "Emblem_Silver"
        case .gold:
            return "Emblem_Gold"
        case .platinum:
            return "Emblem_Platinum"
        case .diamond:
            return "Emblem_Diamond"
        case .master:
            return "Emblem_Master"
        case .grandmaster:
            return "Emblem_Grandmaster"
        case .challenger:
            return "Emblem_Challenger"
        }
    }
}
