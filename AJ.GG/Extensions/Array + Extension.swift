//
//  Array + Extension.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/31.
//

import Foundation

extension Array where Element == Summoner {
    func isFull() -> Bool {
        return self.count == 3 
    }
}
