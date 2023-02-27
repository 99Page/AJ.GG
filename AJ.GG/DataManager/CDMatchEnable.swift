//
//  CDMatchEnable.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/02/23.
//

import CoreData

protocol CDMatchEnable: DataManagerEnable {
    func fetchEntitiesByCDSummoner(_ cdSummoner: CDSummoner) -> [Match]
}

class CDMatchManager: CDMatchEnable {
    typealias CDData = CDMatch
    
    required init(useCase: CoreDataCase) {
        switch useCase {
        case .preview:
            self.context = PersistenceController.preview.container.viewContext
        case .inMemory:
            self.context = PersistenceController.inMemory.container.viewContext
        case .shared:
            self.context = PersistenceController.shared.container.viewContext
        }
    }
    
    var context: NSManagedObjectContext
    
    func fetchEntitiesByCDSummoner(_ cdSummoner: CDSummoner) -> [Match] {
        let request = NSFetchRequest<CDData>(entityName: CDData.entity().name ?? "name")
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(CDMatch.playedBy), cdSummoner)
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(CDMatch.gameCreation), ascending: true)]
        
        do {
            let matches = try self.context.fetch(request)
            return matches.map { Match($0) }
        } catch {
            print("ERROR FETCHING CORE DATA")
            print(error.localizedDescription)
        }
        
        return []
    }
}
