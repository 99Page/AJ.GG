//
//  DataManager.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/02/16.
//

import Foundation
import CoreData

class DataManager<CDData: NSManagedObject>: DataManagerEnable {
    required init(useCase: CoreDataCase) {
        switch useCase {
        case .preview:
            self.context = PersistenceController.preview.container.viewContext
        case .inMemory:
            self.context = PersistenceController.inMemory.container.viewContext
        case .shared:
            self.context = PersistenceController.shared.container.viewContext
        }
    }
    
    var context: NSManagedObjectContext
}

