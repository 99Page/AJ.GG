//
//  ContentView.swift
//  AJ.GG
//
//  Created by 노우영 on 2022/12/26.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        HomeView(matchV5Service: MatchV5Service(),
                 containerSource: PersistentContainer.shared)
    }
}
