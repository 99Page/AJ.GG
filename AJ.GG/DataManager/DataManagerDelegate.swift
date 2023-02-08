//
//  DataManagerDelegate.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/16.
//

import Foundation
import CoreData

protocol DataManagerDelegate {
    associatedtype Data
    associatedtype CDData
    
    var context: NSManagedObjectContext {
        get 
    }
    
    func add(_ data: [String: Any])
    func save()
    func fetchAll() -> [Data]
    func deleteAll()
    func fetchDatas(predicate: NSPredicate?) -> [Data]
    func fetchEntites(predicate: NSPredicate?, sortDescriptor: [NSSortDescriptor]?) -> [CDData]
    func updateEntites(predicate: NSPredicate?, data: [String: Any])
}

extension DataManagerDelegate {
    func save() {
        do {
            try context.save()
//            print("SAVE SUCCESS")
        } catch {
            print("ERROR SAVING CORE DATA")
            print(error.localizedDescription)
        }
    }
}
