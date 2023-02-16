//
//  DataManagerDelegate.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/16.
//

import Foundation
import CoreData

protocol DataManagerEnable {
    associatedtype CDData: NSManagedObject
    
    init(useCase: CoreDataCase)
    
    var context: NSManagedObjectContext {
        get set
    }
    
    func create() -> CDData
    func delete(predicate: NSPredicate?)
    func fetchEntites(predicate: NSPredicate?, sortDescriptor: [NSSortDescriptor]?) -> [CDData]
    func save()
}

extension DataManagerEnable {
    
    func create() -> CDData {
        let entity = NSEntityDescription.insertNewObject(forEntityName: CDData.entity().name ?? "name",
                                                             into: self.context) as! CDData
        
        return entity
    }
    
    func delete(predicate: NSPredicate?) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CDSummoner.fetchRequest()
        fetchRequest.predicate = predicate
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        _ = try? context.execute(batchDeleteRequest)
        save()
    }
    
    func fetchEntites(predicate: NSPredicate? = nil, sortDescriptor: [NSSortDescriptor]? = nil) -> [CDData] {
        let request = NSFetchRequest<CDData>(entityName: CDData.entity().name ?? "name")
        request.predicate = predicate
        request.sortDescriptors = sortDescriptor
        
        do {
            let matches = try self.context.fetch(request)
            return matches
        } catch {
            print("ERROR FETCHING CORE DATA")
            print(error.localizedDescription)
        }
        
        return []
    }
    
    
    func save() {
        do {
            try context.save()
            print("SAVE SUCCESS")
        } catch {
            print("ERROR SAVING CORE DATA")
            print(error.localizedDescription)
        }
    }
}
