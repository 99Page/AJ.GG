//
//  Double + Extension.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/02/01.
//

import Foundation

extension Double {
    var winRate: String {
        let roundedDouble = self.rounded(toPlaces: 3) * 100
        let formattedString = String(format: "%.1f%%", roundedDouble)
        return formattedString
    }
}

extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
