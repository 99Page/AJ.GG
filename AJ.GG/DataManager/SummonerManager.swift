//
//  SummonerManager.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/11.
//

import Foundation
import CoreData

class SummonerManager: DataManagerDelegate {
    
    let context: NSManagedObjectContext
    
    init() {
        self.context = PersistenceController.shared.container.viewContext
    }
    
    func add(_ data: [String: Any]) {
        let insertData = NSEntityDescription.insertNewObject(forEntityName: "CDSummoner",
                                                             into: self.context) as! CDSummoner
        insertData.setValues(data)
        save()
    }
    
    func getAll() -> [CDSummoner] {
        let request = NSFetchRequest<CDSummoner>(entityName: "CDSummoner")
        do {
            let summoners = try context.fetch(request)
            print("Fetch Success")
            return summoners
        } catch {
            print("ERROR FETCHING CORE DATA")
            print(error.localizedDescription)
        }
        
        return [CDSummoner]()
    }
    
    func deleteAll() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CDSummoner.fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        _ = try? context.execute(batchDeleteRequest)
    }
}
