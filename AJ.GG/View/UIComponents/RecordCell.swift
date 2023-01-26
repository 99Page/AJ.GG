//
//  RecordCell.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/25.
//

import SwiftUI

struct RecordCell: View {
    
    let match: MatchDTO
    let summoner: SummonerDTO
    
    var myChampion: Champion {
        match.myChampion(puuid: summoner.puuid)
    }
    
    var rivalChampion: Champion {
        match.rivalChampion(puuid: summoner.puuid)
    }
    
    var resultText: String {
        match.isWinByPuuid(puudid: summoner.puuid) ? "승리" : "패배"
    }
    
    var kda: String {
        "11/2/5"
    }
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 10) {
            CircleChampionImage(champion: myChampion, isEnemy: false)
   
            VStack(alignment: .leading) {
                
                Text(resultText)
                    .padding(.leading, 5)
                
                Rectangle()
                    .stroke(lineWidth: 2)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, minHeight: 1, maxHeight: 1)
                
                Text(kda)
                    .padding(.leading, 5)
            }
            .frame(alignment: .center)
            .padding(.leading, -10)
            
            CircleChampionImage(champion: rivalChampion, isEnemy: true)
                .frame(alignment: .bottom)
        }
        .frame(maxWidth: .infinity, maxHeight: 70)
        
    }
}

struct RecordCell_Previews: PreviewProvider {
    static var previews: some View {
        RecordCell(match: MatchDTO.dummyData(),
                   summoner: SummonerDTO.dummyData())
    }
}
