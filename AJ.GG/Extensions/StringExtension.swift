//
//  StringExtension.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/05.
//

import Foundation

extension String {
    func tier() -> Tier? {
        for tier in Tier.allCases {
            if tier.rawValue == self {
                return tier
            }
        }
        
        return nil 
    }
}
