//
//  CDMatchEnable.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/02/23.
//

import CoreData

final class CDSummonerManager {
    let context: NSManagedObjectContext
    
    init(container: PersistentContainerSource) {
        self.context = container.container.viewContext
    }
    
    func addSummoner(summoner: Summoner, leagueTier: LeagueTier) {
        let summonerEntity = NSEntityDescription.insertNewObject(forEntityName: CDSummoner.entity().name ?? "CDSummoner",
                                                                 into: context) as! CDSummoner
        summonerEntity.id = summoner.summonerID
        summonerEntity.leaguePoints = leagueTier.points
        summonerEntity.profileIconID = summoner.profileIconID
        summonerEntity.puuid = summoner.puuid
        summonerEntity.rank = leagueTier.rank?.rawValue
        summonerEntity.summonerName = summoner.summonerName
        summonerEntity.tier = leagueTier.tier?.rawValue
        
        save()
    }
    
    func fetchAll() -> [Summoner] {
        let request: NSFetchRequest<CDSummoner> = NSFetchRequest(entityName: CDSummoner.entity().name ?? "CDSummoner")
        
        do {
            let summoners = try context.fetch(request)
            return summoners.map { Summoner(cdSummoner: $0) }
        } catch {
            print("ERROR FETCHING")
            return []
        }
    }
    
    func save() {
        do {
            try context.save()
        } catch {
            print("\(error)")
        }
    }
}
