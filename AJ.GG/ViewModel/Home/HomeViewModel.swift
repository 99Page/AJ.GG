//
//  HomeViewModel.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/02.
//

import Foundation
import CoreData


class HomeViewModel: ObservableObject {
    let matchV5Service: MatchV5ServiceEnabled
    let summonerManager: CDSummonerManager
    
    @Published var summoners: [Summoner] = []
    @Published var isSummonerEmpty: Bool = false
    
    init(matchV5Serivce: MatchV5ServiceEnabled, containerSoruce: PersistentContainerSource) {
        self.matchV5Service = MatchV5ServiceInjector.select(service: matchV5Serivce)
        self.summonerManager = CDSummonerManager(container: PersistentContainerInjector.select(source: containerSoruce))
        fetchSummoners()
    }
    
    private func fetchSummoners() {
        self.summoners = summonerManager.fetchAll().map { Summoner(cdSummoner: $0) }
        if summoners.isEmpty {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.isSummonerEmpty = true
            }
        }
    }
}
