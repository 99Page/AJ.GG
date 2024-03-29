//
//  ChampionWinRateImage.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/02/01.
//

import SwiftUI

struct ChampionWinRateImage: View {
    
    let percentage: Double
    let champion: Champion
    let isBlueGraph: Bool
    @State private var animatePercentage = 0.0
    
    var gradient: Gradient {
        isBlueGraph ? Gradient(colors: [.blue, .purple]) : Gradient(colors: [.red, .orange])
    }
       
    var body: some View {
        VStack {
            ZStack {
                BaseChamiponImage(champion: champion)
                    .frame(width: 70, height: 70)
                    .clipShape(Circle())

                Circle()
                    .stroke(Color.gray, lineWidth: 5)
                    .frame(width: 70, height:  70)

                Circle()
                    .trim(from: 0, to: CGFloat(min(percentage, 1)))
                    .stroke(
                        LinearGradient(gradient: gradient, startPoint: .bottom,
                                       endPoint: .top),
                        lineWidth: 5
                    )
                    .frame(width: 70, height:  70)
                    .rotationEffect(Angle(degrees: -90))
                    .animation(.linear(duration: 1), value: animatePercentage)

            }
            .onAppear {
                self.animatePercentage = percentage
            }
            
            Text("\(percentage.winRate)")
                .font(.system(size: 14, weight: .bold))
        }
    }
}

struct ChampionWinRateImage_Previews: PreviewProvider {
    static var previews: some View {
        ChampionWinRateImage(percentage: 0.9367,
                             champion: Champion.dummyTopmMatch(),
                             isBlueGraph: false)
    }
}
