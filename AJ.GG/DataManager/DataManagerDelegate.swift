//
//  DataManagerDelegate.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/16.
//

import Foundation
import CoreData

protocol DataManagerDelegate {
    associatedtype CDData: AllSettable
    
    var context: NSManagedObjectContext {
        get 
    }
    
    func add(_ data: [String: Any])
    func save()
    func getAll() -> [CDData]
    func deleteAll()
}

extension DataManagerDelegate {
    func save() {
        do {
            try context.save()
            print("SAVE SUCCESS")
        } catch {
            print("ERROR SAVING CORE DATA")
            print(error.localizedDescription)
        }
    }
}
