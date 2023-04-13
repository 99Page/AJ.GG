//
//  CDMatchEnable.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/02/23.
//

import CoreData

final class CDSummonerManager: DataManagerProtocol {
    
    let context: NSManagedObjectContext
    
    init(container: PersistentContainerSource) {
        self.context = container.container.viewContext
    }
    
    func addSummoner(summoner: Summoner, leagueTier: LeagueTier) {
        let summonerEntity = NSEntityDescription.insertNewObject(forEntityName: CDSummoner.entity().name ?? "CDSummoner",
                                                                 into: context) as! CDSummoner
        summonerEntity.setValues(summoner: summoner, leagueTier: leagueTier)
        save()
    }
    
    func fetchAll() -> [CDSummoner] {
        let request: NSFetchRequest<CDSummoner> = NSFetchRequest(entityName: CDSummoner.entity().name ?? "CDSummoner")
        
        do {
            let summoners = try context.fetch(request)
            return summoners
        } catch {
            print("ERROR FETCHING")
            return []
        }
    }
    
    func deleteAll() {
        let summoners = self.fetchAll()
        for summoner in summoners {
            context.delete(summoner)
        }
    }
}

extension CDSummoner {
    func setValues(summoner: Summoner, leagueTier: LeagueTier) {
        self.id = summoner.summonerID
        self.leaguePoints = leagueTier.points
        self.profileIconID = summoner.profileIconID
        self.puuid = summoner.puuid
        self.rank = leagueTier.rank?.rawValue
        self.summonerName = summoner.summonerName
        self.tier = leagueTier.tier?.rawValue
        
    }
}
