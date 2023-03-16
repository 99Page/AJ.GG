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
        
        addSummoner()
    }
    
    private func addSummoner() {
        let context = container.viewContext
        let summoner = NSEntityDescription.insertNewObject(forEntityName: CDSummoner.entity().name ?? "CDSummoner", into: context) as! CDSummoner
        summoner.setValues(summoner: Summoner.dummyData(), leagueTier: LeagueTier.dummyData())
        
        do {
            try context.save()
        } catch {
            print("ERROR SAVING CORE DATA")
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
    }
}


enum PersistentContainerInjector: String {
    case empty = "empty"
    case pre = "preview"
    case run = "run"
    
    var container: PersistentContainerSource {
        switch self {
        case .empty:
            return EmptyPersistentContainer()
        case .pre:
            return PreviewPersistentContainer()
        case .run:
            return PersistentContainer()
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
