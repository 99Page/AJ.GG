//
//  RecordCell.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/25.
//

import SwiftUI

struct RecordCell: View {
    
    let match: Match
    let height: CGFloat = 70
    
    let myChampionImageSize: CGSize = CGSize(width: 70, height: 70)
    let rivalChampionImageSize: CGSize = CGSize(width: 60, height: 60)
    
    var myChampion: Champion {
        match.myChampion
    }
    
    var rivalChampion: Champion {
        match.rivalChampion
    }
    
    var resultText: String {
        match.isWin ? "승리" : "패배"
    }
    
    var myKDA: String {
        let kda = match.myKDA
        return "\(kda[0])/\(kda[1])/\(kda[2])"
    }
    
    var rivalKDA: String {
        let kda = match.rivalKDA
        return "\(kda[0])/\(kda[1])/\(kda[2])"
    }
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 10) {
            CircleChampionImage(champion: myChampion, size: myChampionImageSize)
   
            VStack(alignment: .leading) {
                
                HStack {
                    Text(resultText)
                        .padding(.leading, 5)
                    
                    Spacer()
                    
                    Text(match.rivalSummonerName)
                }
                
                Rectangle()
                    .stroke(lineWidth: 2)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, minHeight: 1, maxHeight: 1)
                
                HStack {
                    Text(myKDA)
                        .padding(.leading, 5)
                    
                    Spacer()
                    
                    Text(rivalKDA)
                }
            }
            .frame(maxHeight: .infinity, alignment: .center)
            .padding(.leading, -10)
            

            CircleChampionImage(champion: rivalChampion, size: rivalChampionImageSize)
                .frame(alignment: .bottom)
        }
        .frame(maxWidth: .infinity, maxHeight: height)
        
    }
}

struct RecordCell_Previews: PreviewProvider {
    static var previews: some View {
        RecordCell(match: Match.dummyData())
    }
}
