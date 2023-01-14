//
//  MatchManager.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/12.
//

import Foundation
import CoreData

extension Match {
    convenience init(matchDTO: MatchDTO, puuid: String, context: NSManagedObjectContext) {
        self.init(context: context)
        self.id = matchDTO.getMatchID()
        self.myChmpionID = matchDTO.getChampionNameByPuuid(puuid: puuid)
        self.enemyChampionID = matchDTO.getEnemyChampionNameByPuuid(puuid: puuid)
        self.lane = matchDTO.getLaneByPuuid(puuid: puuid)?.rawValue
        self.isWin = matchDTO.isWingByPuuid(puudid: puuid)
        self.version = matchDTO.getVersion()
    }
}


class MatchManager {
    
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
    
    func save(matchDTO: MatchDTO, puuid: String) {
        
        let matches = self.getAll()
        
        guard !matches.contains( where: { matchDTO.isEqualMatchID(match: $0) }) else { return }
        let data = Match(matchDTO: matchDTO, puuid: puuid, context: container.viewContext)
        print(data)
        
        do {
            try container.viewContext.save()
        } catch {
            print("ERROR SAVING CORE DATA")
            print(error.localizedDescription)
        }
    }
    
    func getAll() -> [Match] {
        let request = NSFetchRequest<Match>(entityName: "Match")
        do {
            let matches = try container.viewContext.fetch(request)
            print("Fetch Success")
            return matches
        } catch {
            print("ERROR FETCHING CORE DATA")
            print(error.localizedDescription)
        }
        
        return [Match]()
    }
    
    func deleteAll() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Match.fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        _ = try? container.viewContext.execute(batchDeleteRequest)
    }
    
}
