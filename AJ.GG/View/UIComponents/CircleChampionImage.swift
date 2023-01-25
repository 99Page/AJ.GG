//
//  CircleChampionImage.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/25.
//

import SwiftUI

struct CircleChampionImage: View {
    
    
    let champion: Champion
    let isEnemy: Bool
    
    init(champion: Champion, isEnemy: Bool) {
        self.champion = champion
        self.isEnemy = isEnemy
    }
    
    var outsideColor: Color {
        isEnemy ? Color.red : Color.blue
    }
    
    var size: CGSize {
        isEnemy ? CGSize(width: 50, height: 50) : CGSize(width: 70, height: 70)
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
        CircleChampionImage(champion: Champion.dummyChampion(), isEnemy: false)
    }
}
