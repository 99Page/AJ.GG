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
    
    
    init() {
        self.context = PersistenceController.shared.container.viewContext
    }
    
    func add(_ data: CDMatch) {
        
        let matches = self.getAll()
        guard !matches.contains( where: { data.isEqual($0) }) else { return }
        let insertData = NSEntityDescription.insertNewObject(forEntityName: "Match", into: self.context) as! CDMatch
        insertData.copy(data)
        save()
    }
    
    func getAll() -> [CDMatch] {
        let request = NSFetchRequest<CDMatch>(entityName: "Match")
        request.sortDescriptors = [NSSortDescriptor(key: "gameCreation", ascending: false)]
        do {
            let matches = try self.context.fetch(request)
            print("Fetch Success")
            return matches
        } catch {
            print("ERROR FETCHING CORE DATA")
            print(error.localizedDescription)
        }
        
        return [CDMatch]()
    }
    
    func deleteAll() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CDMatch.fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        _ = try? self.context.execute(batchDeleteRequest)
    }
    
}
