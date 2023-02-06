//
//  Match + Extension.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/24.
//

import Foundation
import CoreData

extension CDMatch {
    func isEqual(_ object: CDMatch) -> Bool {
        return self.id == object.id
    }
}

extension CDMatch: AllSettable {
    func setValues(_ data: [String : Any]) {
        for (k, v) in data {
            self.setValue(v, forKey: k)
        }
    }
}


