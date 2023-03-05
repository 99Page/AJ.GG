//
//  HomeViewModel.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/02.
//

import Foundation
import CoreData


class ProfileViewModel: ObservableObject {
    let matchV5Service: MatchV5ServiceEnable
    
    init(matchV5Serivce: MatchV5ServiceEnable) {
        self.matchV5Service = matchV5Serivce
    }
}
