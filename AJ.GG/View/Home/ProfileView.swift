//
//  HomeView.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/02.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {

    struct ViewItem: Identifiable {
        var id = UUID().uuidString
        let champion: Champion
        let isMyChampion: Bool
    }

    @StateObject var viewModel: HomeViewModel
    @State private var item: ViewItem?

    let lanes = Lane.selectableLanes()

    init() {
        self._viewModel = StateObject(wrappedValue: HomeViewModel(matchV5Serivce: MatchV5Service(),
                                                                     containerSoruce: PersistentContainer()))
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("HomeView")
            }
            .padding(.horizontal)
            
            .navigationDestination(isPresented: $viewModel.isSummonerEmpty) {
                SummonerRegistrationView()
            }
            .frame(maxWidth: .infinity)
        }
        .accessibilityIdentifier("HomeView")
        .padding(.top, 1)
        .overlay(alignment: .top) {
            HStack {
                SummonerProfiles(summoners: viewModel.summoners)
                    .padding(.horizontal)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(0)
        }
    }

//    @ViewBuilder
//    private func myBestChampions() -> some View {
//        Group {
//            Text("나의 베스트 챔피언")
//                .font(.system(size: 15, weight: .heavy))
//
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack {
//                    ForEach(viewModel.myChampionWithRates.indices, id: \.self) { i in
//
//                        let champion = viewModel.myChampionWithRates[i].champion
//                        let percentage = viewModel.myChampionWithRates[i].winRate
//
//                        Button {
//                            self.item = ViewItem(champion: champion, isMyChampion: true)
//                            self.viewModel.counterRecordStrategy = MyRecordStrategy()
//                        } label: {
//                            ChampionWinRateImage(percentage: percentage,
//                                                 champion: champion,
//                                                 isBlueGraph: true)
//                        }
//                        .foregroundColor(.black)
//                    }
//                }
//                .frame(height: 100)
//            }
//            .padding(.horizontal, -10)
//        }
//    }
//
//    @ViewBuilder
//    private func hardRivalChampions() -> some View {
//        Group {
//              Text("어려운 챔피언")
//                  .font(.system(size: 15, weight: .heavy))
//
//
//              ScrollView(.horizontal, showsIndicators: false) {
//                  HStack {
//                      ForEach(viewModel.rivalChampionWithRates.indices, id: \.self) { i in
//
//                          let champion = viewModel.rivalChampionWithRates[i].champion
//                          let percentage = viewModel.rivalChampionWithRates[i].loseRate
//
//                          Button {
//                              self.item = ViewItem(champion: champion, isMyChampion: false)
//                              self.viewModel.counterRecordStrategy = RivalCounterRecordStrategy()
//                          } label: {
//                              ChampionWinRateImage(percentage: percentage,
//                                                   champion: champion,
//                                                   isBlueGraph: false)
//                          }
//                          .foregroundColor(.black)
//                      }
//                  }
//                  .frame(height: 100)
//              }
//              .padding(.horizontal, -10)
//        }
//    }
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

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView(summonerManager: DataManager(useCase: .preview),
//                    matchManager: DataManager(useCase: .preview),
//                    matchV5Service: MatchV5Service())
//    }
//}
