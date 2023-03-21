//
//  BaseChamiponImage.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/25.
//

import SwiftUI
import Kingfisher

struct BaseChamiponImage: View {
    
    let champion: Champion
    
    var url: String {
        RiotURL.championSquareAsset(champion: champion.name).url
    }
    
    var body: some View {
        KFImage(URL(string: url))
            .resizable()
    }
}

struct BaseChamiponImage_Previews: PreviewProvider {
    static var previews: some View {
        BaseChamiponImage(champion: Champion.dummyTopmMatch())
    }
}
