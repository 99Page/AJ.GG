//
//  HomeView.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/02.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {

    @StateObject var viewModel: ProfileViewModel
    
    let lanes = Lane.selectableLanes()
    
    @State var text = ""
    
    let headerHeight: CGFloat = 90
    
    init(summonerManager: SummonerManager = SummonerManager(), matchManager: MatchManager = MatchManager(), matchV5Service: MatchV5ServiceEnable) {
        self._viewModel = StateObject(wrappedValue: ProfileViewModel(summonerManager: summonerManager,
                                                                     matchManager: matchManager,
                                                                     matchV5Service: matchV5Service))
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                HStack {
                    ForEach(lanes, id: \.rawValue) { lane in
                        Button {
                            Task { await viewModel.laneButtonTapped(lane) }
                        } label: {
                            LaneImage(lane: lane, isSelected: lane.isEqual(viewModel.selectedLane))
                        }
                        .disabled(viewModel.selectedLane.isEqual(lane))
                    }
                }
                .padding(.horizontal, 80)

                CapsuleText(text: $text, title: "카운터 검색")

                Group {
                    myBestChampions()
                    hardRivalChampions()
                    records()
                }
                .hidden(viewModel.isMatchEmpty)

                VStack(alignment: .center, spacing: 10) {
                    BaseProfileIconImage(iconID: IconID.piratePoro.rawValue)
                        .clipShape(RoundedRectangle(cornerRadius: 50))
                    
                    HStack(alignment: .top, spacing: 10) {
                        Image(systemName: "exclamationmark.circle")
                            .font(.system(size: 20))
                        
                        Text("해당 라인의 정보가 수집되지 않았습니다.")
                            .font(.system(size: 20, weight: .heavy))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)
                .hidden(!viewModel.isMatchEmpty)
//
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
        ProfileView(summonerManager: SummonerManager(inPreview: true),
                    matchManager: MatchManager(inPreview: true),
                    matchV5Service: MatchV5Service())
    }
}
