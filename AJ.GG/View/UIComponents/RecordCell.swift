//
//  RecordCell.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/25.
//

import SwiftUI

struct RecordCell: View {
    
    let match: Match
    
    var body: some View {
        HStack {
            
            CircleChampionImage(champion: match.myChampion, isEnemy: false)
            
            VStack {
                Rectangle()
                    .stroke(lineWidth: 2)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
            }
            
            CircleChampionImage(champion: match.rivalChampion, isEnemy: true)
        }
        .frame(alignment: .bottom)
    }
}

//struct RecordCell_Previews: PreviewProvider {
//    static var previews: some View {
//        RecordCell()
//    }
//}
