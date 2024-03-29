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
                RecordCell(match: matches[i])
                Divider()
                    .foregroundColor(.black)
            }
        }
        .accessibilityIdentifier("RecordView")
    }
}

//struct RecordView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecordView()
//    }
//}
