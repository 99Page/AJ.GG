//
//  DataManagerProtocol.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/03/16.
//

import Foundation
import CoreData

protocol DataManagerProtocol {
    var context: NSManagedObjectContext { get }
    func save()
}

extension DataManagerProtocol {
    func save() {
        do {
            try context.save()
        } catch {
            print("\(error)")
        }
    }
}
