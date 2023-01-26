//
//  SummonerManager.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/11.
//

import Foundation
import CoreData

class SummonerManager: DataManagerDelegate {
    typealias Data = Summoner
    
    typealias CDData = Summoner
    
    let context: NSManagedObjectContext
    
    init() {
        self.context = PersistenceController.shared.container.viewContext
    }
    
    func add(_ data: Summoner) {
        let insertData = NSEntityDescription.insertNewObject(forEntityName: "Summoner",
                                                             into: self.context) as! Summoner
        insertData.copy(data)
        save()
    }
    
    func getAll() -> [Summoner] {
        let request = NSFetchRequest<Summoner>(entityName: "Summoner")
        do {
            let summoners = try context.fetch(request)
            print("Fetch Success")
            return summoners
        } catch {
            print("ERROR FETCHING CORE DATA")
            print(error.localizedDescription)
        }
        
        return [Summoner]()
    }
    
    func deleteAll() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Summoner.fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        _ = try? context.execute(batchDeleteRequest)
    }
    
}
