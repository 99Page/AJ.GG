//
//  ChampionRecordView.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/02/07.
//

import SwiftUI

struct ChampionRecordView: View {
    
    let champion: Champion
    let matches: [Match]
    let context: CounterRecordContext
    
    init (champion: Champion, matches: [Match], recordStrategy: RecordStrategy) {
        self.champion = champion
        self.matches = matches
        self.context = CounterRecordContext(strategy: recordStrategy)
        
        print("\(recordStrategy.self)")
    }
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
//
//                ChampionWinRateImagesSection(title: "[\(viewModel.championName)] 상대하기 쉬운 챔피언",
//                                             winRate: true,
//                                             championWithWinRates: viewModel.championWithRates)
//
                
                ChampionWinRateImagesSection(title: context.title(champion: champion),
                                             winRate: context.winRate,
                                             championWithWinRates: context.sort(matches: matches))
//
//
                Text("[\(champion.name)] 전적")
                    .font(.system(size: 14, weight: .heavy))
                RecordView(matches: matches)
            }
            .padding(.all, 10)
        }
        .padding(.top, 10)
    }
}

struct ChampionRecordView_Previews: PreviewProvider {
    static var previews: some View {
        ChampionRecordView(champion: Champion(name: "Aatrox"),
                           matches: Match.dummyDatas(),
                           recordStrategy: MyCounterRecordStrategy())
    }
}
