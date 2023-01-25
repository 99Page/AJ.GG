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

extension CDMatch: Copyable {
    func copy(_ origin: CDMatch) {
        self.id = origin.id
        self.myChmpionID = origin.myChmpionID
        self.enemyChampionID = origin.enemyChampionID
        self.lane = origin.lane
        self.isWin = origin.isWin
        self.version = origin.version
        self.gameCreation = origin.gameCreation
    }
    
    typealias Data = CDMatch
    
    
}

extension CDMatch {
    convenience init(matchDTO: MatchDTO, puuid: String, context: NSManagedObjectContext) {
        self.init(context: context)
        self.id = matchDTO.getMatchID()
        self.myChmpionID = matchDTO.getChampionNameByPuuid(puuid: puuid)
        self.enemyChampionID = matchDTO.getEnemyChampionNameByPuuid(puuid: puuid)
        self.lane = matchDTO.getLaneByPuuid(puuid: puuid)?.rawValue
        self.isWin = matchDTO.isWingByPuuid(puudid: puuid)
        self.version = matchDTO.getVersion()
        self.gameCreation = matchDTO.gameCreation
    }
}
