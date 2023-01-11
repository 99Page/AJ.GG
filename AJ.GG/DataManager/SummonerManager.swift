//
//  SummonerManager.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/11.
//

import Foundation
import CoreData

class SummonerManager {
    
    let container: NSPersistentContainer
    
    
    init() {
        self.container = NSPersistentContainer(name: "AJ_GG")
        
        container.loadPersistentStores { description, error in
           if let error = error {
               print("ERROR LOADING CORE DATA")
               print(error.localizedDescription)
           } else {
               print("SUCCESSFULLY LOAD CORE DATA : Register")
           }
       }
    }
    
    func save(summonerDTO: SummonerDTO, tier: LeagueTier?) {
        _ = Summoner(summonerDTO: summonerDTO, leagueTier: tier, context: self.container.viewContext)
        
        do {
            try container.viewContext.save()
        } catch {
            print("ERROR SAVING CORE DATA")
            print(error.localizedDescription)
        }
    }
    
    func getAll() -> [Summoner] {
        let request = NSFetchRequest<Summoner>(entityName: "Summoner")
        do {
            let summoners = try container.viewContext.fetch(request)
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
        _ = try? container.viewContext.execute(batchDeleteRequest)
    }
    
}
