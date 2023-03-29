//
//  HomeView.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/02.
//

import SwiftUI
import Kingfisher

struct HomeView: View {
    
    enum SheetDestination {
        case myCounter
        case rivalCounter
    }
    
    struct ViewItem: Identifiable {
        var id = UUID().uuidString
        let champion: Champion
        let dest: SheetDestination
    }

    @StateObject var viewModel: HomeViewModel
    @State private var item: ViewItem?
    @State private var isPresented: Bool = false

    let lanes = Lane.selectableLanes()

    init() {
        self._viewModel = StateObject(wrappedValue: HomeViewModel(matchV5Serivce: MatchV5Service(),
                                                                     containerSoruce: PersistentContainer()))
    }

    var body: some View {
        VStack(spacing: 5) {
            
            HStack {
                SummonerProfiles(summoners: viewModel.summoners)
                    .padding(.horizontal)
                
                Spacer()
            }
            
            HStack {
                ForEach(lanes, id: \.self) { lane in
                    let image = viewModel.selectedLane == lane ?
                    lane.image : lane.imageUnselected
                    
                    Button {
                        viewModel.laneButtonTapped(lane)
                    } label: {
                        Image(image)
                            .resizable()
                            .frame(width: 40, height: 40)
                    }

                }
            }
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    myBestChampions()
                    hardRivalChampions()
                    RecordView(matches: viewModel.matchesByLane)
                }
                .padding(.horizontal)
                .navigationDestination(isPresented: $viewModel.isSummonerEmpty) {
                    SummonerRegistrationView()
                }
                .sheet(item: $item) { item in
                    
                    switch item.dest {
                    case .myCounter:
                        let matches = viewModel.matchesByLane.filter {
                            $0.myChampionName == item.champion.name
                        }
                        
                        ChampionRecordView(champion: item.champion,
                                           matches: matches,
                                           recordStrategy: MyCounterRecordStrategy())
                            .presentationDetents([.medium, .large])
                    case .rivalCounter:
                        let matches = viewModel.matchesByLane.filter {
                            $0.rivalChampionName == item.champion.name
                        }
                        
                        ChampionRecordView(champion: item.champion,
                                           matches: matches,
                                           recordStrategy: RivalCounterRecordStrategy())
                            .presentationDetents([.medium, .large])
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .accessibilityIdentifier("HomeView")
        }
    }

    @ViewBuilder
    private func myBestChampions() -> some View {
        Group {
            Text("나의 베스트 챔피언")
                .font(.system(size: 15, weight: .heavy))

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.rivalCount.indices, id: \.self) { i in

                        let champion = viewModel.rivalCount[i].champion
                        let percentage = viewModel.rivalCount[i].winRate

                        Button {
                            self.item = ViewItem(champion: champion,
                                                 dest: .myCounter)
                        } label: {
                            ChampionWinRateImage(percentage: percentage,
                                                 champion: champion,
                                                 isBlueGraph: true)
                        }
                        .foregroundColor(.black)
                    }
                }
                .frame(height: 100)
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
                      ForEach(viewModel.myCounter.indices, id: \.self) { i in

                          let champion = viewModel.myCounter[i].champion
                          let percentage = viewModel.myCounter[i].loseRate

                          Button {
                              self.item = ViewItem(champion: champion,
                                                   dest: .rivalCounter)
                          } label: {
                              ChampionWinRateImage(percentage: percentage,
                                                   champion: champion,
                                                   isBlueGraph: false)
                          }
                          .foregroundColor(.black)
                      }
                  }
                  .frame(height: 100)
              }
              .padding(.horizontal, -10)
        }
    }
//
//    @ViewBuilder
//    private func records() -> some View {
//        Group {
//            Text("전적")
//                .font(.system(size: 14, weight: .heavy))
//
//            RecordView(matches: viewModel.matchesByLane)
//        }
//    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
