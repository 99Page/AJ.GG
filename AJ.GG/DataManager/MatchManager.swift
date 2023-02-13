//
//  MatchManager.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/12.
//

import Foundation
import CoreData

class MatchManager: DataManagerDelegate {
    
    typealias CDData = CDMatch
    typealias Data = Match
    
    let context: NSManagedObjectContext
    
    required init(inPreview: Bool = false) {
        if inPreview {
            self.context = PersistenceController.preview.container.viewContext
        } else {
            self.context = PersistenceController.shared.container.viewContext
        }
        
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
    
    func add(_ data: [String : Any]) {
        let insertData = NSEntityDescription.insertNewObject(forEntityName: "CDMatch",
                                                             into: self.context) as! CDMatch
        insertData.setValues(data)
        save()
    }
    
    func fetchAll() -> [Match] {
        let request = NSFetchRequest<CDMatch>(entityName: "CDMatch")
        request.sortDescriptors = [NSSortDescriptor(key: "gameCreation", ascending: false)]
        do {
            let matches = try self.context.fetch(request)
            return matches.map { Match($0) }
        } catch {
            print("ERROR FETCHING CORE DATA")
            print(error.localizedDescription)
        }
        
        return []
    }
    
    func fetchDatas(predicate: NSPredicate?) -> [Match] {
        let request = NSFetchRequest<CDMatch>(entityName: "CDMatch")
        request.predicate = predicate
        request.sortDescriptors = [NSSortDescriptor(key: "gameCreation", ascending: false)]
        
        do {
            let matches = try self.context.fetch(request)
            return matches.map { Match($0) }
        } catch {
            print("ERROR FETCHING CORE DATA")
            print(error.localizedDescription)
        }
        
        return []
    }
    
    func fetchEntites(predicate: NSPredicate?, sortDescriptor: [NSSortDescriptor]?) -> [CDMatch] {
        let request = NSFetchRequest<CDMatch>(entityName: "CDMatch")
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
    
    func updateEntites(predicate: NSPredicate?, data: [String: Any]) {
        let request = NSFetchRequest<CDMatch>(entityName: "CDMatch")
        request.predicate = predicate
        
        do {
            let matches = try self.context.fetch(request)
            print("매치수 : \(matches.count)")
            for match in matches {
                match.setValues(data)
                save()
            }
        } catch {
            print("ERROR FETCHING CORE DATA")
            print(error.localizedDescription)
        }
    }
    
   
    
    func deleteAll() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CDMatch.fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        _ = try? self.context.execute(batchDeleteRequest)
    }
    
}
