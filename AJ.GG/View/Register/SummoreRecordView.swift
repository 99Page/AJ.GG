//
//  SummoreRecordView.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/03/13.
//

import SwiftUI

struct SummoreRecordView: View {
    
    @ObservedObject var viewModel: SummonerRegistrationViewModel
    var body: some View {

        GeometryReader { outer in
            let safeAreaTop = outer.safeAreaInsets.top
            ScrollView {
                
                
                HStack {
                    Image(systemName: "exclamationmark.circle")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.gray)

                    Text("최근 20게임 중 랭크게임만 표시됩니다.")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.gray)

                    Spacer()
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
            }
            .accessibilityIdentifier("SummonerRecordView")
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
//                .overlay {
//                    hiddenTitle(safeAreaTop: safeAreaTop)
//                }
//            }
//            .keyboardHideWhenScreenTapped()
//            .overlay(alignment: .bottom) {
//                registerButton()
//
//            }
//            .coordinateSpace(name: self.spaceName)
//            .toolbar {
//                ToolbarItem(placement: .keyboard) {
//                    keyboardButton()
//                }
//            }
//            .accessibilityIdentifier("SummonerRegistrationView")
//            .onAppear {
//                self.focusState = .summonerName
//            }
        }
        .padding(.init(top: 1, leading: 0, bottom: 0, trailing: 0))
        .navigationBarBackButtonHidden()
    }
    
//    @ViewBuilder
//    private func registerButton() -> some View {
//        Button {
//
//        } label: {
//            Text("등록하기")
//        }
//        .accessibilityIdentifier("RegisterButton")
//        .padding(.horizontal, 15)
//        .padding(.vertical, 10)
//        .overlay {
//            RoundedRectangle(cornerRadius: 5)
//                .stroke()
//                .foregroundColor(.blue)
//        }
//        .padding(.horizontal, 30)
//        .hidden(!viewModel.isSearched)
//    }
//    @ViewBuilder
//    private func recordProgreeView() -> some View {
//        if viewModel.isSearching {
//            VStack(alignment: .center) {
//                RotatingCircle()
//                Text("전적을 검색중입니다.")
//            }
//            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
//        }
//    }
//
//    @ViewBuilder
//    private func record() -> some View {
//        RecordView(matches: viewModel.matches)
//            .padding(.horizontal, 10)
//            .padding(.bottom, registerButtonHeight)
//    }
//
//    @ViewBuilder
//    private func hiddenTitle(safeAreaTop: CGFloat) -> some View {
//        if let summoner = viewModel.searchedSummoner {
//            HiddenTitle(spaceName: self.spaceName, headerHeight: 50, topSafeArea: safeAreaTop) {
//                HStack {
//                    viewModel.emblemImage
//                        .resizable()
//                        .frame(maxWidth: 50, maxHeight: 50)
//
//                    Text("\(summoner.name)")
//                }
//                .padding(.top, safeAreaTop)
//                .frame(maxWidth: .infinity, maxHeight: 50 + safeAreaTop)
//                .background(Color.white)
//                .offset(y: -safeAreaTop)
//                .onTapGesture {
//                    self.focusState = .summonerName
//                }
//            }
//        }
//    }
}

struct SummoreRecordView_Previews: PreviewProvider {
    static var previews: some View {
        SummoreRecordView(viewModel: SummonerRegistrationViewModel(summonerService: MockSummonerSerivceSuccess(), leagueV4Service: MockLeagueV4ServiceSuccess(), matchV5Service: MockMatchV5ServiceSuccess()))
    }
}
