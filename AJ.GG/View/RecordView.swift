//
//  RecordView.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/13.
//

import SwiftUI
import Kingfisher

struct RecordView: View {
    
    let matches: [CDMatch]
    var body: some View {
        VStack {
            ForEach(matches.indices, id: \.self) { i in
                HStack {
                    Text("내 챔피언")
                    
                    KFImage(URL(string: RiotURL.championSquareAsset(champion: matches[i].myChmpionID ?? "Aatrox").url))
                    
                    Text("상대 챔피언")
                    
                    KFImage(URL(string: RiotURL.championSquareAsset(champion: matches[i].enemyChampionID ?? "Aatrox").url))
//
////
                    Text(matches[i].isWin ? "승리" : "패배")
//
//                    Text(matches[i].lane ?? "에러")
                }
            }
        }
    }
}
//
//struct RecordView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecordView()
//    }
//}
