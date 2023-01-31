//
//  LaneImage.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/31.
//

import SwiftUI

struct LaneImage: View {
    
    let lane: Lane
    
    var body: some View {
        Image(lane.imageName)
            .resizable()
            .scaledToFit()
    }
}

struct LaneImage_Previews: PreviewProvider {
    static var previews: some View {
        LaneImage(lane: Lane.top)
    }
}
