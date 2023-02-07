//
//  ChampionWinRateImagesSection.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/02/07.
//

import SwiftUI

struct ChampionWinRateImagesSection: View {
    
    let title: String
    let winRate: Bool
    let championWithWinRates: [ChampionWithRate]
    
    var sorted: [ChampionWithRate] {
        winRate ? championWithWinRates.sorted() : championWithWinRates.sorted().reversed()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text(title)
                .font(.system(size: 15, weight: .heavy))
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(sorted.indices, id: \.self) { i in
                        
                        let champion =  sorted[i].champion
                        let percentage = winRate ? sorted[i].winRate : sorted[i].loseRate
                        
                        ChampionWinRateImage(percentage: percentage,
                                             champion: champion,
                                             isBlueGraph: winRate ? true : false)
                       
                    }
                }
                .frame(height: 100)
            }
        }
    }
}

struct ChampionWinRateImagesSection_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            ChampionWinRateImagesSection(title: "나의 베스트 챔피언", winRate: true, championWithWinRates: ChampionWithRate.dummyDatas())
            
            ChampionWinRateImagesSection(title: "상대하기 어려운 챔피언", winRate: false, championWithWinRates: ChampionWithRate.dummyDatas())
        }
    }
}
