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
    
    var body: some View {
        KFImage(URL(string: RiotURL.championSquareAsset(champion: champion.name).url))
            .resizable()
    }
}

struct BaseChamiponImage_Previews: PreviewProvider {
    static var previews: some View {
        BaseChamiponImage(champion: Champion.dummyChampion())
    }
}
