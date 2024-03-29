//
//  Persistence.swift
//  AJ.GG
//
//  Created by 노우영 on 2022/12/26.
//

import CoreData

protocol PersistentContainerSource {
    var container: NSPersistentCloudKitContainer { get }
    static var shared: PersistentContainerSource { get }
}

struct PreviewPersistentContainer: PersistentContainerSource {
    let container: NSPersistentCloudKitContainer
    static var shared: PersistentContainerSource = PreviewPersistentContainer()
    init() {
        container = NSPersistentCloudKitContainer(name: "AJ_GG")
        container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        
        addSummoner()
    }
    
    private func addSummoner() {
        let context = container.viewContext
        let summoner = NSEntityDescription.insertNewObject(forEntityName: CDSummoner.entity().name ?? "CDSummoner", into: context) as! CDSummoner
        
        summoner.setValues(summoner: Summoner.dummyTopmMatch(), leagueTier: LeagueTier.dummyTopmMatch())
        addMatcheInSummoner(summonerEntity: summoner)
        
        do {
            try context.save()
        } catch {
            print("ERROR SAVING CORE DATA")
        }
    }
    
    private func addMatcheInSummoner(summonerEntity: CDSummoner) {
        let match = NSEntityDescription.insertNewObject(forEntityName: CDMatch.entity().name ?? "CDMatch", into: container.viewContext) as! CDMatch
        match.setValues(summonerEntity: summonerEntity, match: Match.dummyTopmMatch())
        
        do {
            try container.viewContext.save()
        } catch {
            
        }
        
        let midMatch = NSEntityDescription.insertNewObject(forEntityName: CDMatch.entity().name ?? "CDMatch", into: container.viewContext) as! CDMatch
        midMatch.setValues(summonerEntity: summonerEntity, match: Match.dummyMidMatch())
        
        do {
            try container.viewContext.save()
        } catch {
            
        }
    }
}

struct EmptyPersistentContainer: PersistentContainerSource {
    let container: NSPersistentCloudKitContainer
    static var shared: PersistentContainerSource = EmptyPersistentContainer()
    init() {
        container = NSPersistentCloudKitContainer(name: "AJ_GG")
        container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
    }
}

struct PersistentContainer: PersistentContainerSource {
    let container: NSPersistentCloudKitContainer
    static var shared: PersistentContainerSource = PersistentContainer()
    
    init() {
        container = NSPersistentCloudKitContainer(name: "AJ_GG")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
    }
}


enum PersistentContainerInjector: String {
    case empty = "empty"
    case pre = "preview"
    case run = "run"
    
    var container: PersistentContainerSource {
        switch self {
        case .empty:
            return EmptyPersistentContainer.shared
        case .pre:
            return PreviewPersistentContainer.shared
        case .run:
            return PersistentContainer.shared
        }
    }
    
    static func select(source: PersistentContainerSource) -> PersistentContainerSource {
           if let variable = ProcessInfo.processInfo.environment["-ContainerSource"] {
               return PersistentContainerInjector(rawValue: variable)?.container ?? source
           } else {
               return source
           }
       }
}
