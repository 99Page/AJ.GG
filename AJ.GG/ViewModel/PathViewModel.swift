//
//  PathViewModel.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/04/12.
//

import SwiftUI

class PathViewModel: ObservableObject {
    @Published var path: NavigationPath = .init()
    
    func navigateTo(_ destination: DestinationFactory) {
        path.append(destination)
    }
    
    func pathInit() {
        path = .init()
    }
}
