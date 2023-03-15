//
//  SummoreRecordView.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/03/13.
//

import SwiftUI

struct SummonerRecordView: View {
    
    @ObservedObject var viewModel: SummonerRegistrationViewModel
    var body: some View {

        GeometryReader { outer in
            let safeAreaTop = outer.safeAreaInsets.top
            ScrollView {
                VStack(alignment: .leading) {
                    if let summoner = viewModel.summoner, let tier = viewModel.leagueTier {
                        
                        Text(summoner.summonerName)
                            .font(.system(size: 25, weight: .bold))
                        
                        HStack {
                            tier.emblemImage
                                .resizable()
                                .frame(width: 50, height:50)
                                .scaledToFit()
                            
                            Text("\(tier.tier?.rawValue ?? "")")
                                .font(.system(size: 12, weight: .semibold))
                            Text("\(tier.rank?.rawValue ?? "")")
                                .font(.system(size: 12, weight: .semibold))
                        }
                        .roundedRectangle(color: .gray)
                        .padding(.horizontal, -30)
                        .padding(.vertical, -5)
                        
                        HStack {
                            Image(systemName: "exclamationmark.circle")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.gray)

                            Text("최근 20게임 중 랭크게임만 표시됩니다.")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.gray)

                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 5)
                        
                        record()
                            .overlay {
                                RotatingCircle()
                                    .hidden(!viewModel.isSearchOngoing)
                            }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.horizontal, 10)
            }
            .accessibilityIdentifier("SummonerRecordView")
        }
        .padding(.init(top: 1, leading: 0, bottom: 0, trailing: 0))
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    viewModel.isPresentedAddSummonerAlert = true
                } label: {
                    Image(systemName: "star")
                        .fontWeight(.bold)
                }
                .alert(isPresented: $viewModel.isPresentedAddSummonerAlert) {
                    Alert(title: Text("소환사를 추가하시겠습니까?"),
                          primaryButton: .default(Text("확인"), action: {
                        viewModel.addSummoner()
                    }),
                          secondaryButton: .cancel(Text("취소")))
                }
            }
        }
    }
    
    @ViewBuilder
    private func record() -> some View {
        RecordView(matches: viewModel.matches)
            .padding(.horizontal, 10)
    }
}

//struct SummoreRecordView_Previews: PreviewProvider {
//    static var previews: some View {
//
//        @StateObject static var viewModel = SummonerRegistrationViewModel(summonerService: MockSummonerSerivceSuccess(), leagueV4Service: MockLeagueV4ServiceSuccess(), matchV5Service: MockMatchV5ServiceSuccess())
//
//        SummonerRecordView(viewModel: viewModel)
//            .onAppear {
//                Task { await viewModel.searchButtonTapped() }
//            }
//    }
//}
