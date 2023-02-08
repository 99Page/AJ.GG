//
//  SummonerManager.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/11.
//

import Foundation
import CoreData

class SummonerManager: DataManagerDelegate {
    typealias CDData = CDSummoner
    typealias Data = Summoner
    
    let context: NSManagedObjectContext
    
    init(preview: Bool) {
        if preview {
            self.context = PersistenceController.preview.container.viewContext
        } else {
            self.context = PersistenceController.shared.container.viewContext
        }
    }
    
    func add(_ data: [String: Any]) {
        let insertData = NSEntityDescription.insertNewObject(forEntityName: "CDSummoner",
                                                             into: self.context) as! CDSummoner
        insertData.setValues(data)
        save()
    }
    
    func fetchAll() -> [Summoner] {
        let request = NSFetchRequest<CDSummoner>(entityName: "CDSummoner")
        do {
            let summoners = try context.fetch(request)
            print("Fetch Success")
            return summoners.map { Summoner(cdSummoner: $0) }
        } catch {
            print("ERROR FETCHING CORE DATA")
            print(error.localizedDescription)
        }
        
        return []
    }
    
    func fetchDatas(predicate: NSPredicate?) -> [Summoner] {
        let request = NSFetchRequest<CDSummoner>(entityName: "CDSummoner")
        request.predicate = predicate
        
        
        do {
            let summoners = try context.fetch(request)
            return summoners.map { Summoner(cdSummoner: $0) }
        } catch {
            print("ERROR FETCHING CORE DATA")
            print(error.localizedDescription)
        }
        
        return []
        
    }
    
    func fetchEntites(predicate: NSPredicate?, sortDescriptor: [NSSortDescriptor]?) -> [CDSummoner] {
        let request = NSFetchRequest<CDSummoner>(entityName: "CDSummoner")
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
        let request = NSFetchRequest<CDSummoner>(entityName: "CDSummoner")
        
        request.predicate = predicate
        do {
            let entities = try self.context.fetch(request)
            for entity in entities {
                entity.setValues(data)
            }
        } catch {
            print("ERROR FETCHING CORE DATA")
            print(error.localizedDescription)
        }
    }
    
    
    func deleteAll() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CDSummoner.fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        _ = try? context.execute(batchDeleteRequest)
    }
}

