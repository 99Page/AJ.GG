//
//  ChampionRecordView.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/02/07.
//

import SwiftUI

struct ChampionRecordView: View {
    
    @StateObject private var viewModel: ChampionRecordViewModel
    
    init(champion: Champion, isMyChampion: Bool, matchManager: MatchManager) {
        self._viewModel = StateObject(
            wrappedValue: ChampionRecordViewModel(champion: champion,
                                                  matchManager: matchManager,
                                                  isMyChampion: isMyChampion)
        )
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                
                ChampionWinRateImagesSection(title: "[\(viewModel.championName)] 상대하기 쉬운 챔피언",
                                             winRate: true,
                                             championWithWinRates: viewModel.championWithRates)
                
                
                ChampionWinRateImagesSection(title: "[\(viewModel.championName)] 상대하기 어려운 챔피언",
                                             winRate: false,
                                             championWithWinRates: viewModel.championWithRates)
             
                
                Text("[\(viewModel.championName)] 전적")
                    .font(.system(size: 14, weight: .heavy))
                RecordView(matches: viewModel.matches)
            }
            .padding(.all, 10)
        }
        .padding(.top, 10)
    }
}

struct ChampionRecordView_Previews: PreviewProvider {
    static var previews: some View {
        ChampionRecordView(champion: Champion(name: "Aatrox"),
                           isMyChampion: true,
                           matchManager: MatchManager(inPreview: true))
    }
}
