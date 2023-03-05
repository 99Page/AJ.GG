//
//  CDMatchEnable.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/02/23.
//

import CoreData

class CDSummonerManager {
    let context: NSManagedObjectContext
    
    init(container: PersistentContainerSource) {
        self.context = container.container.viewContext
    }
}
