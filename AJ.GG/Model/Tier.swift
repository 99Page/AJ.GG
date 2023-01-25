//
//  Tier.swift
//  AJ.GG
//
//  Created by 노우영 on 2022/12/29.
//

import Foundation
import SwiftUI

struct LeagueTier {
    let tier: Tier?
    let rank: Rank?
    let points: Int32
    
    var emblemImage: Image {
        self.tier?.emblemImage ?? Tier.bronze.emblemImage
    }
}

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
    
    var emblemImage: Image {
        switch self {
        case .iron:
            return Image("Emblem_Iron")
        case .bronze:
            return Image("Emblem_Bronze")
        case .silver:
            return Image("Emblem_Silver")
        case .gold:
            return Image("Emblem_Gold")
        case .platinum:
            return Image("Emblem_Platinum")
        case .diamond:
            return Image("Emblem_Diamond")
        case .master:
            return Image("Emblem_Master")
        case .grandmaster:
            return Image("Emblem_Grandmaster")
        case .challenger:
            return Image("Emblem_Challenger")
        }
    }
}

extension Tier {
    init? (_ tierString: String) {
        switch tierString {
        case "IRON":
            self = .iron
        case "BRONZE":
            self = .bronze
        case "SILVER":
            self = .silver
        case "GOLD":
            self = .gold
        case "PLATINUM":
            self = .platinum
        case "DIAMOND":
            self = .diamond
        case "MASTER":
            self = .master
        case "GRANDMASTER":
            self = .grandmaster
        case "CHALLENGER":
            self = .challenger
        default:
            return nil 
        }
    }
}

enum Rank: String {
    case i = "I"
    case ii = "II"
    case iii = "III"
    case iv = "IV"
}
