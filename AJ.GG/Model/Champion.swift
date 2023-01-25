//
//  Champion.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/10.
//

import Foundation

struct Champion {
    private let _name: String
    
    init(name: String) {
        self._name = name
    }
    
    var name: String {
        _name
    }
    
    static func dummyChampion() -> Champion {
        
        let championNames = ["Aatrox", "Garen", "Darius"]
        return Champion(name: championNames.randomElement() ?? "Aatrox")
    }
}
