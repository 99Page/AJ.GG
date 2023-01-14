//
//  RecordView.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/13.
//

import SwiftUI
import Kingfisher

struct RecordView: View {
    
    let matches: [Match]
    var body: some View {
        VStack {
            ForEach(matches.indices, id: \.self) { i in
                HStack {
                    Text("내 챔피언 : \(matches[i].myChmpionID ?? "에러")")
                    
                    Text("상대 챔피언 : \(matches[i].enemyChampionID ?? "에러")")
                    
                    if let url: URL = URL(string: RiotURL.championSquareAsset(champion: matches[i].myChmpionID ?? "Aatrox").url) {
                        KFImage(url)
                            .resizable()
                            .frame(width: 30, height: 30)
                    } else {
                        Text("???")
                    }
                    
                    
                    Text(matches[i].isWin ? "승리" : "패배")
                    
                    Text(matches[i].lane ?? "에러")
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
