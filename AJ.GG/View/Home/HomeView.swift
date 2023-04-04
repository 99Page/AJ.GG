//
//  HomeView.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/02.
//

import SwiftUI
import Kingfisher
import PopupView

struct HomeView: View {
    
    struct ViewItem: Identifiable {
        var id = UUID().uuidString
        let champion: Champion
        let matchFilterContext: MatchFilterContext
        let strategy: RecordStrategy
    }

    @StateObject var viewModel: HomeViewModel
    @State private var item: ViewItem?
    @State private var isPresented: Bool = false

    let lanes = Lane.selectableLanes()

    init(matchV5Service: MatchV5ServiceEnabled, containerSource: PersistentContainerSource) {
        self._viewModel = StateObject(wrappedValue: HomeViewModel(matchV5Serivce: matchV5Service,
                                                                     containerSoruce: containerSource))
    }

    var body: some View {
        VStack(spacing: 5) {
            
            HStack {
                if let summoner = viewModel.summoners.first {
                    SummonerProfile(summoner: summoner)
                }
                Spacer()
                
                NavigationLink {
                    SummonerRegistrationView()
                } label: {
                    Text("소환사 변경")
                        .font(.system(size: 10, weight: .heavy))
                        .foregroundColor(.blue)
                        .roundedRectangle(color: .blue)
                }
            }
            .padding(.leading, 20)
            
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
                    let matches = item.matchFilterContext.execute(matches: viewModel.matchesByLane,
                                                                  champion: item.champion)
                    
                    ChampionRecordView(champion: item.champion,
                                       matches: matches,
                                       recordStrategy: item.strategy)
                        .presentationDetents([.medium, .large])
                }
                .frame(maxWidth: .infinity)
            }
            .accessibilityIdentifier("HomeView")
        }
        .popup(isPresented: $viewModel.showSuccessToast) {
            Text("새로운 매치 저장을 성공했습니다.")
                .padding(.top, 50)
                .padding(.leading, 20)
                .frame(maxWidth: .infinity, maxHeight: 80, alignment: .leading)
                .foregroundColor(.white)
                .font(.system(size: 15, weight: .bold))
                .background(Color.blue)
        } customize: {
            $0
                .type(.toast)
                .position(.top)
                .animation(.spring(blendDuration: 1))
                .closeOnTap(true)
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
                        let matchFilterContext = MatchFilterContext(strategy: MyChampionFilterStrategy())

                        Button {
                            self.item = ViewItem(champion: champion,
                                                 matchFilterContext: matchFilterContext,
                                                 strategy: MyCounterRecordStrategy())
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
                                                   matchFilterContext: MatchFilterContext(strategy: RivalChampionFilterStrategy()),
                                                   strategy: RivalCounterRecordStrategy())
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
        HomeView(matchV5Service: MockMatchV5ServiceSuccess(),
                 containerSource: PreviewPersistentContainer.shared)
    }
}
