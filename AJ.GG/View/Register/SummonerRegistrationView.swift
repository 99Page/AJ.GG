//
//  RegisterSummonerView.swift
//  AJ.GG
//
//  Created by 노우영 on 2022/12/26.
//

import SwiftUI
import CoreData
import Combine

struct SummonerRegistrationView: View {

    enum Field: String, Hashable {
        case summonerName
    }
    
    @StateObject private var viewModel = SummonerRegistrationViewModel(summonerService: SummonerService(),
                                                                       leagueV4Service: LeagueV4Serivce(),
                                                                       matchV5Service: MatchV5Service())
    @FocusState private var focusState: Field?

//    let spaceName: String = "scroll"
//    let registerButtonHeight: CGFloat = 50
//
//    var isShowingRegisterButton: Bool {
//        viewModel.isSearched && self.focusState == nil
//    }

    var body: some View {

        GeometryReader { outer in
            let safeAreaTop = outer.safeAreaInsets.top
            ScrollView {
                PGVStack {
                    TextField(viewModel.title, text: $viewModel.summonerName)
                        .font(.system(size: 15, weight: .heavy))
                        .focused($focusState, equals: .summonerName)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 10)
                        .overlay {
                            RoundedRectangle(cornerRadius: 5)
                                .stroke()
                                .foregroundColor(.gray)
                        }
                        .padding(.horizontal, 30)
                        .onSubmit {
                            Task {
                                await viewModel.searchButtonTapped()
                            }
                        }
                        .accessibilityIdentifier("SummonerNameText")
                        .submitLabel(.search)
                        .alert(isPresented: $viewModel.isPresented) {
                            Alert(title: Text("에러"))
                        }
//
//                    HStack {
//                        Image(systemName: "exclamationmark.circle")
//                            .font(.system(size: 16, weight: .bold))
//                            .foregroundColor(.gray)
//
//                        Text("최근 20게임 중 랭크게임만 표시됩니다.")
//                            .font(.system(size: 16, weight: .bold))
//                            .foregroundColor(.gray)
//
//                        Spacer()
//                    }
//                    .padding(.horizontal, 10)
//                    .padding(.vertical, 5)
//                    .hidden(!viewModel.isSearched)
//
//                    record()
                }
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
//                .overlay {
//                    hiddenTitle(safeAreaTop: safeAreaTop)
//                }
//            }
//            .keyboardHideWhenScreenTapped()
//            .overlay {
//                recordProgreeView()
//            }
//            .overlay(alignment: .bottom) {
//                registerButton()
//            }
//            .coordinateSpace(name: self.spaceName)
//            .toolbar {
//                ToolbarItem(placement: .keyboard) {
//                    keyboardButton()
//                }
            }
            .accessibilityIdentifier("SummonerRegistrationView")
            .onAppear {
                self.focusState = .summonerName
            }
        }
        .padding(.init(top: 1, leading: 0, bottom: 0, trailing: 0))
        .navigationBarBackButtonHidden()
    }


//    @V3
//
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
//    private func keyboardButton() -> some View {
//        HStack {
//
//            Button {
//                focusState = nil
//            } label: {
//                Text("종료")
//            }
//
//            Button {
//                Task { await viewModel.searchButtonTapped() }
//                focusState = nil
//            } label: {
//                Text("검색")
//            }
//        }
//        .frame(maxWidth: .infinity, alignment: .trailing)
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

struct RegisterSummonerView_Previews: PreviewProvider {
    static var previews: some View {
        SummonerRegistrationView()
    }
}
