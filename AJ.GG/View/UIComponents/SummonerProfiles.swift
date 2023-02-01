//
//  SummonersProfile.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/31.
//

import SwiftUI

struct SummonerProfiles: View {
    
    let summoners: [Summoner]
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                if !summoners.isFull() {
                    Image(systemName: "plus")
                        .frame(width: 60, height: 60)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 20)
                        )
                        .overlay {
                            RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 3)
                        }
                }
                
                ForEach(summoners.indices, id: \.self) { i in
                    SummonerProfile(summoner: summoners[i])
                }
            }
        }
    }
}

struct SummonerProfiles_Previews: PreviewProvider {
    static var previews: some View {
        SummonerProfiles(summoners: Summoner.dummyDatas())
    }
}
