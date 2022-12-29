//
//  AJ_GGApp.swift
//  AJ.GG
//
//  Created by 노우영 on 2022/12/26.
//

import SwiftUI

@main
struct AJ_GGApp: App {
    
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
