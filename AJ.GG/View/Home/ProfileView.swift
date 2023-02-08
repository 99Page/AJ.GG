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
                                                       matchManager: MatchManager(),
                                                       matchV5Service: MatchV5Service())
    
    let lanes = Lane.selectableLanes()
    
    @State var text = ""
    
    let headerHeight: CGFloat = 90
    
    var body: some View {
        ScrollView {
            PGVStack(alignment: .leading, spacing: 20) {
                HStack {
                    ForEach(lanes, id: \.rawValue) { lane in
                        Button {
                            viewModel.laneButtonTapped(lane)
                        } label: {
                            LaneImage(lane: lane, isSelected: lane.isEqual(viewModel.selectedLane))
                        }
                        .disabled(viewModel.selectedLane.isEqual(lane))
                    }
                }
                .padding(.horizontal, 80)
                
                CapsuleText(text: $text, title: "카운터 검색")
                
                myBestChampions()
                hardRivalChampions()
//                ChampionWinRateImagesSection(title: "나의 베스트 챔피언",
//                                             winRate: true,
//                                             championWithWinRates: viewModel.myChampionWithRates)
//
//                ChampionWinRateImagesSection(title: "상대하기 어려운 챔피언",
//                                             winRate: false,
//                                             championWithWinRates: viewModel.rivalChampionWithRates)
            
                records()
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
            }
            .padding(0)
        }
    }
    
    @ViewBuilder
    private func myBestChampions() -> some View {
        Group {
            Text("나의 베스트 챔피언")
                .font(.system(size: 15, weight: .heavy))

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.myChampionWithRates.indices, id: \.self) { i in

                        let champion = viewModel.myChampionWithRates[i].champion
                        let percentage = viewModel.myChampionWithRates[i].winRate
                        
                        Button {
                            self.viewModel.selectedChampion = champion
                        } label: {
                            ChampionWinRateImage(percentage: percentage,
                                                 champion: champion,
                                                 isBlueGraph: true)
                        }
                        .foregroundColor(.black)
                    }
                }
                .frame(height: 100)
                .sheet(item: $viewModel.selectedChampion) {
                    ChampionRecordView(champion: $0,
                                       isMyChampion: true,
                                       matchManager: MatchManager())
                    .presentationDetents([.medium, .large])
                }
            }
            .padding(.horizontal, -10)
        }
    }

    @ViewBuilder
    private func hardRivalChampions() -> some View {
        Group {
              Text("어려운 챔피언")
                  .font(.system(size: 15, weight: .heavy))


              ScrollView(.horizontal, showsIndicators: false) {
                  HStack {
                      ForEach(viewModel.rivalChampionWithRates.indices, id: \.self) { i in

                          let champion = viewModel.rivalChampionWithRates[i].champion

                          ChampionWinRateImage(percentage: viewModel.rivalChampionWithRates[i].loseRate,
                                               champion: champion,
                                               isBlueGraph: false)
                      }
                  }
                  .frame(height: 100)
              }
              .padding(.horizontal, -10)
        }
    }
    
    @ViewBuilder
    private func records() -> some View {
        Group {
            Text("전적")
                .font(.system(size: 14, weight: .heavy))

            RecordView(matches: viewModel.matches)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: ProfileViewModel(summonerManager: SummonerManager(preview: true),
                                                matchManager: MatchManager(inPreview: true),
                                                matchV5Service: MatchV5Service()))
    }
}
