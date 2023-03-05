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
    }
}

struct MockPersistentContainer: PersistentContainerSource {
    let container: NSPersistentCloudKitContainer
    static var shared: PersistentContainerSource = MockPersistentContainer()
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
