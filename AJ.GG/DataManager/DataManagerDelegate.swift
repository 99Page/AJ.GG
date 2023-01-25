//
//  DataManagerDelegate.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/16.
//

import Foundation
import CoreData

protocol DataManagerDelegate {
    associatedtype CDData: Copyable
    associatedtype Data
    
    var context: NSManagedObjectContext {
        get 
    }
    
    func add(_ data: CDData)
    func save()
    func getAll() -> [CDData]
    func deleteAll()
}

extension DataManagerDelegate {
    func save() {
        do {
            try context.save()
        } catch {
            print("ERROR SAVING CORE DATA")
            print(error.localizedDescription)
        }
    }
}
