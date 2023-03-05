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
    
    func fetchAll() -> [Summoner] {
        let request: NSFetchRequest<CDSummoner> = NSFetchRequest(entityName: CDSummoner.entity().name ?? "CDSummoner")
        
        do {
            let summoners = try context.fetch(request)
            return summoners.map { Summoner(cdSummoner: $0) }
        } catch {
            print("ERROR FETCHING")
            return []
        }
    }
}
