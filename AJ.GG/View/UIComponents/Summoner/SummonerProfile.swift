//
//  SummonerSelectView.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/31.
//

import SwiftUI

struct SummonerProfile: View {
    
    let summoner: Summoner
    
    var body: some View {
        VStack {
            BaseProfileIconImage(summoner: summoner)
                .frame(width: 60, height: 60)
                .clipShape(
                    RoundedRectangle(cornerRadius: 20)
                )
                .overlay {
                    RoundedRectangle(cornerRadius: 20).stroke(LinearGradient(gradient: Gradient(colors: [.orange, .red]), startPoint: .bottom, endPoint: .top), lineWidth: 3)
                }
            
            Text("\(summoner.summonerName)")
                .font(.system(size: 12, weight: .semibold))
        }
    }
}

struct SummonerProfile_Previews: PreviewProvider {
    static var previews: some View {
        SummonerProfile(summoner: Summoner.dummyData())
    }
}
