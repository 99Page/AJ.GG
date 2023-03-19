//
//  CDMatchManager.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/03/16.
//

import Foundation
import CoreData

final class CDMatchManager: DataManagerProtocol {
    
    let context: NSManagedObjectContext
    
    init(container: PersistentContainerSource) {
        self.context = container.container.viewContext
    }
    
    func add(summonerEntity: CDSummoner, match: Match) {
        let matchEntity = NSEntityDescription.insertNewObject(forEntityName: CDMatch.entity().name ?? "CDMatch",
                                                              into: context) as! CDMatch
        matchEntity.setValues(summonerEntity: summonerEntity, match: match)
        save()
    }
    
    func fetchBySummoner(sumonerEntity: CDSummoner) -> [CDMatch] {
        let request: NSFetchRequest<CDMatch> = NSFetchRequest(entityName: CDMatch.entity().name ?? "CDMatch")
        let predicate = NSPredicate(format: "%K == %@", #keyPath(CDMatch.playedBy), sumonerEntity)
        let sortDescriptor = NSSortDescriptor(key: #keyPath(CDMatch.gameCreation), ascending: true)
        
        request.predicate = predicate
        request.sortDescriptors = [sortDescriptor]
        
        do {
            let matchEntities = try context.fetch(request)
            return matchEntities
        } catch {
            print("ERROR FETCHING")
            return []
        }
    }
}
