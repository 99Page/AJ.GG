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
        matchEntity.gameCreation = match.gameCreation
        matchEntity.id = match.id
        matchEntity.isWin = match.isWin
        matchEntity.lane = match.lane.rawValue
        matchEntity.version = match.version
        
        let myKDA = match.myKDA
        matchEntity.myAssist = myKDA[2]
        matchEntity.myChampionID = match.myChampionName
        matchEntity.myKill = myKDA[0]
        matchEntity.myDeath = myKDA[1]
        matchEntity.mySummonerName = match.mySummonerName
        
        let rivalKDA = match.rivalKDA
        matchEntity.enemyChampionID = match.rivalChampionName
        matchEntity.rivalKill = rivalKDA[0]
        matchEntity.rivalDeath = rivalKDA[1]
        matchEntity.rivalAssist = rivalKDA[2]
        matchEntity.rivalSummonerName = match.rivalSummonerName
        
        summonerEntity.addToPlays(matchEntity)
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
