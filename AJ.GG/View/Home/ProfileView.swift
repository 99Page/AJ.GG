//
//  HomeView.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/02.
//

import SwiftUI

struct ProfileView: View {

    @StateObject
    var viewModel: ProfileViewModel = ProfileViewModel(summonerManager: SummonerManager(preview: false))
    
    let lanes = Lane.selectableLanes()
    
    let tmpChampions = Champion.dummyDatas()
    @State private var text: String = ""
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                SummonerProfiles(summoners: viewModel.summoners)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            ScrollView {
                PGVStack(alignment: .leading, spacing: 20) {
                    HStack {
                        ForEach(lanes, id: \.rawValue) { lane in
                            LaneImage(lane: lane)
                        }
                    }
                    .padding(.horizontal, 80)
                    
                    CapsuleText(text: $text, title: "카운터 검색")
                    
                    Text("나의 베스트 챔피언")
                        .font(.system(size: 14, weight: .heavy))
                    
                    HStack {
                        ForEach(tmpChampions) { data in
                            let rate = [0.2, 0.9]
                            ChampionWinRateImage(percentage: rate.randomElement()!, champion: data, isBlueGraph: true)
                                .padding(.horizontal, 5)
                        }
                    }
                    
                    Text("어려운 챔피언")
                        .font(.system(size: 14, weight: .heavy))
                    
                    
                    HStack {
                        ForEach(tmpChampions) { data in
                            let rate = [0.2, 0.9]
                            ChampionWinRateImage(percentage: rate.randomElement()!, champion: data, isBlueGraph: false)
                                .padding(.horizontal, 5)
                        }
                    }
                    
                    Text("전적")
                        .font(.system(size: 14, weight: .heavy))
                    
                    RecordView(matches: Match.dummyDatas())
                }
                .padding(.horizontal)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: ProfileViewModel(summonerManager: SummonerManager(preview: true)))
    }
}
