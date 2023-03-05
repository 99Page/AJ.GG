//
//  HomeViewModel.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/02.
//

import Foundation
import CoreData


class HomeViewModel: ObservableObject {
    let matchV5Service: MatchV5ServiceEnable
    let summonerManager: CDSummonerManager
    
    @Published var summoners: [Summoner] = []
    @Published var isSummonerEmpty: Bool = false
    
    init(matchV5Serivce: MatchV5ServiceEnable, containerSoruce: PersistentContainerSource) {
        self.matchV5Service = matchV5Serivce
        self.summonerManager = CDSummonerManager(container: PersistentContainerInjector.select(source: containerSoruce))
        
        fetchSummoners()
    }
    
    private func fetchSummoners() {
        self.summoners = summonerManager.fetchAll()
        if summoners.isEmpty {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.isSummonerEmpty = true
            }
        }
    }
}
