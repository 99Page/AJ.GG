//
//  AJ_GGApp.swift
//  AJ.GG
//
//  Created by 노우영 on 2022/12/26.
//

import SwiftUI

@main
struct AJ_GGApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    #if DEBUG
                    UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
                    #endif
                }
        }
    }
}
