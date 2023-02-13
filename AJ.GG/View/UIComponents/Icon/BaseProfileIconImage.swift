//
//  BaseProfileIconImage.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/31.
//

import SwiftUI
import Kingfisher

struct BaseProfileIconImage: View {
    
    let iconID: Int
    var body: some View {
        KFImage(URL(string: RiotURL.profileIcon(iconID).url))
            .resizable()
    }
}

struct BaseProfileIconImage_Previews: PreviewProvider {
    static var previews: some View {
        BaseProfileIconImage(iconID: IconID.piratePoro.rawValue)
    }
}
