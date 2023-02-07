//
//  Persistence.swift
//  AJ.GG
//
//  Created by 노우영 on 2022/12/26.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        for _ in 0..<1 {
            let insertData = NSEntityDescription.insertNewObject(forEntityName: "CDSummoner",
                                                                 into: viewContext) as! CDSummoner
            insertData.summonerName = "SwiftUI"
            insertData.profileIconID = 660
        }
        
        for i in 0...5 {
            let insertData = NSEntityDescription.insertNewObject(forEntityName: "CDMatch",
                                                                 into: viewContext) as! CDMatch
            
            insertData.enemyChampionID = "Gwen"
            insertData.gameCreation = 10000
            insertData.myAssist = 5
            insertData.id = String(i)
            insertData.isWin = true
            insertData.myChampionID = "Aatrox"
            insertData.lane = "TOP"
            insertData.myDeath = 5
            insertData.myKill = 10
            insertData.mySummonerName = "SwiftUI"
            insertData.rivalKill = 1
            insertData.rivalDeath = 3
            insertData.rivalAssist = 10
            insertData.rivalSummonerName = "Jeus"
            insertData.version = "3.14"
        }
        
        for i in 6...10 {
            let insertData = NSEntityDescription.insertNewObject(forEntityName: "CDMatch",
                                                                 into: viewContext) as! CDMatch
            
            insertData.enemyChampionID = "Gwen"
            insertData.gameCreation = 10000
            insertData.myAssist = 5
            insertData.id = String(i)
            insertData.isWin = true
            insertData.myChampionID = "Aatrox"
            insertData.lane = "MIDDLE"
            insertData.myDeath = 5
            insertData.myKill = 10
            insertData.mySummonerName = "SwiftUI"
            insertData.rivalKill = 1
            insertData.rivalDeath = 3
            insertData.rivalAssist = 10
            insertData.rivalSummonerName = "Faker"
            insertData.version = "3.14"
        }
        
        let insertData = NSEntityDescription.insertNewObject(forEntityName: "CDMatch",
                                                             into: viewContext) as! CDMatch
        
        insertData.enemyChampionID = "Gwen"
        insertData.gameCreation = 10000
        insertData.myAssist = 5
        insertData.id = "1236"
        insertData.isWin = false
        insertData.myChampionID = "Aatrox"
        insertData.lane = "MIDDLE"
        insertData.myDeath = 5
        insertData.myKill = 10
        insertData.mySummonerName = "SwiftUI"
        insertData.rivalKill = 1
        insertData.rivalDeath = 3
        insertData.rivalAssist = 10
        insertData.rivalSummonerName = "Faker"
        insertData.version = "3.14"
        
        let insertData2 = NSEntityDescription.insertNewObject(forEntityName: "CDMatch",
                                                             into: viewContext) as! CDMatch
        insertData2.enemyChampionID = "Gwen"
        insertData2.gameCreation = 10000
        insertData2.myAssist = 5
        insertData2.id = "1237"
        insertData2.isWin = true
        insertData2.myChampionID = "Ryze"
        insertData2.lane = "MIDDLE"
        insertData2.myDeath = 5
        insertData2.myKill = 10
        insertData2.mySummonerName = "SwiftUI"
        insertData2.rivalKill = 1
        insertData2.rivalDeath = 3
        insertData2.rivalAssist = 10
        insertData2.rivalSummonerName = "Faker"
        insertData2.version = "3.14"
//        for _ in 0..<10 {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//        }
        
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    
    

    let container: NSPersistentCloudKitContainer

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "AJ_GG")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
