//
//  CircleChampionImage.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/25.
//

import SwiftUI

struct CircleChampionImage: View {
    
    
    let champion: Champion
    let size: CGSize
    
    init(champion: Champion, size: CGSize) {
        self.champion = champion
        self.size = size
    }
    
    var outsideColor: Color {
        size.width < 70 ? Color.red : Color.blue
    }
   
    var body: some View {
        BaseChamiponImage(champion: champion)
            .frame(cgsize: size)
            .clipShape(Circle())
            .overlay {
                Circle().stroke(lineWidth: 2).foregroundColor(.white)
                    .padding(3)
            }
            .overlay {
                Circle().stroke(lineWidth: 2).foregroundColor(outsideColor)
            }
    }
}

struct CircleChampionImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleChampionImage(champion: Champion.dummyTopmMatch(), size: CGSize(width: 70, height: 70))
    }
}
