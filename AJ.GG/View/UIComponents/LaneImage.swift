//
//  LaneImage.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/31.
//

import SwiftUI

struct LaneImage: View {
    
    let lane: Lane
    let isSelected: Bool
    
    var imageString: String {
        isSelected ? lane.image : lane.imageUnselected
    }
    var body: some View {
        Image(imageString)
            .resizable()
            .scaledToFit()
    }
}

struct LaneImage_Previews: PreviewProvider {
    static var previews: some View {
        LaneImage(lane: Lane.top, isSelected: true)
    }
}
