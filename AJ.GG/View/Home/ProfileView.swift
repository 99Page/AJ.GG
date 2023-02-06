//
//  HomeView.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/02.
//

import SwiftUI

struct ProfileView: View {

    @StateObject
    var viewModel: ProfileViewModel = ProfileViewModel(summonerManager: SummonerManager(preview: false),
                                                       matchManager: MatchManager(), matchV5Service: MatchV5Service())
    
    let lanes = Lane.selectableLanes()
    let tmpChampions = Champion.dummyDatas()
    
    @State var text = ""
    @State var title = "TOP"
    
    let headerHeight: CGFloat = 90
    
    var lanesTitle: [String] {
        lanes.map { $0.rawValue }
    }
    
    var body: some View {
        ScrollView {
            PGVStack(alignment: .leading, spacing: 20) {
                HStack {
                    ForEach(lanes, id: \.rawValue) { lane in
                        Button {
                            viewModel.selectedLane = lane
                        } label: {
                            LaneImage(lane: lane)
                        }
                    }
                }
                .padding(.horizontal, 80)
                
                CapsuleText(text: $text, title: "카운터 검색")
                
                Text("나의 베스트 챔피언")
                    .font(.system(size: 14, weight: .heavy))
                
                
                HStack {
                    ForEach(viewModel.myChampionRecords.indices, id: \.self) { i in
                        ChampionWinRateImage(percentage: viewModel.myChampionRecords[i].winRate, champion: viewModel.myChampionRecords[i].champion, isBlueGraph: true)
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
                
                RecordView(matches: viewModel.filterdMatchsByLane)
            }
            .padding(.horizontal)
        }
        .padding(.top, headerHeight)
        .overlay(alignment: .top) {
            HStack(alignment: .center) {
                SummonerProfiles(summoners: viewModel.summoners)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, maxHeight: headerHeight, alignment: .leading)
                    .background(Color.white)
                
//                DropDown(selection: $title, content: lanesTitle, activeTint: .primary.opacity(0.1), inActiveTint: .white.opacity(0.05), dynamic: false)
            }
            .padding(0)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: ProfileViewModel(summonerManager: SummonerManager(preview: true),
                                                matchManager: MatchManager(inPreview: true), matchV5Service: MatchV5Service()))
    }
}
