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
        self.setValue(data["enemyChampionID"], forKey: "enemyChampionID")
        self.setValue(data["gameCreation"], forKey: "gameCreation")
        self.setValue(data["id"], forKey: "id")
        self.setValue(data["isWin"], forKey: "isWin")
        self.setValue(data["lane"], forKey: "lane")
        self.setValue(data["myChampionID"], forKey: "myChampionID")
        self.setValue(data["version"], forKey: "version")
        self.setValue(data["playedBy"], forKey: "playedBy")
    }
}


