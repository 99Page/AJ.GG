//
//  ChampionRecordViewModel.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/02/07.
//

import Foundation
import CoreData

class ChampionRecordViewModel: ObservableObject {
    
    let champion: Champion
    let matchManager: DataManager<CDMatch>
    
    @Published var context: CounterRecordContext
    @Published var matches: [Match] = []
    @Published var championWithRates: [ChampionWithRate] = [] 
   
    var championName: String {
        self.champion.name
    }
    
    init(champion: Champion, matchManager: DataManager<CDMatch>, strategy: RecordStrategy) {
        self.champion = champion
        self.matchManager = matchManager
        self.context = CounterRecordContext(strategy: strategy)
        self.fetchEntities()
        self.championWithRates = context.sort(matches: matches)
        
        print("\(self.championWithRates)")
    }
    
    private func fetchEntities() {
        let predicate: NSPredicate = context.predicate(championName: championName)
        self.matches = matchManager.fetchEntites(predicate: predicate).map({ Match($0) })
        print("\(matches)")
    }
}
