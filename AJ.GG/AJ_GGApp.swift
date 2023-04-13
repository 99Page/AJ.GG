//
//  AJ_GGApp.swift
//  AJ.GG
//
//  Created by 노우영 on 2022/12/26.
//

import SwiftUI

@main
struct AJ_GGApp: App {
    
    @StateObject private var pathViewModel = PathViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView(matchV5Service: MatchV5Service(),
                     containerSource: PersistentContainer.shared)
                .environmentObject(pathViewModel)
                .onAppear {
                    #if DEBUG
                    UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
                    #endif
                }
        }
    }
}
