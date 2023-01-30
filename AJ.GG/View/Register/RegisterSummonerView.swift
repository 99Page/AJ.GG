//
//  RegisterSummonerView.swift
//  AJ.GG
//
//  Created by 노우영 on 2022/12/26.
//

import SwiftUI
import CoreData
import Combine

struct RegisterSummonerView: View {
    
    enum Field: String, Hashable {
        case summonerName
    }
    
    @StateObject private var viewModel = RegisterSummonerViewModel(
        summonerService: SummonerService(),
        leagueV4Service: LeagueV4Serivce(),
        matchV5Service: MatchV5Service())
    @FocusState private var focusState: Field?
    
    let spaceName: String = "scroll"
    let registerButtonHeight: CGFloat = 50
    
    var isShowingRegisterButton: Bool {
        viewModel.isSearched && self.focusState == nil
    }
    
    var body: some View {
        
        GeometryReader { outer in
            let safeAreaTop = outer.safeAreaInsets.top
            ScrollView {
                PGVStack {
                    CapsuleText(text: $viewModel.summonerName,
                                title: viewModel._title)
                        .padding(.horizontal, 30)
                        .focused($focusState, equals: .summonerName)
                        .onSubmit {
                            Task {
                                viewModel.buttonTapped
                            }
                        }
                    record()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .overlay {
                    hiddenTitle(safeAreaTop: safeAreaTop)
                }
            }
            .keyboardHideWhenScreenTapped()
            .overlay {
                recordProgreeView()
            }
            .overlay(alignment: .bottom) {
                registerButton()
            }
            .coordinateSpace(name: self.spaceName)
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    keyboardButton()
                }
            }
        }
        .padding(.init(top: 1, leading: 0, bottom: 0, trailing: 0))
        .hidden(viewModel.isRegistered)
    }

    
    @ViewBuilder
    private func registerButton() -> some View {
        if isShowingRegisterButton {
            Button {
                viewModel.registerButtonTapped()
            } label: {
                Text("등록하기")
                    .frame(maxWidth: .infinity, maxHeight: registerButtonHeight, alignment: .center)
                    .background(Color.blue)
                    .foregroundColor(.white)
            }
        }
    }
    
    @ViewBuilder
    private func recordProgreeView() -> some View {
        if viewModel.isSearching {
            VStack(alignment: .center) {
                Loader()
                Text("전적을 검색중입니다.")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
    }
    
    @ViewBuilder
    private func record() -> some View {
        if let summoner = viewModel.searchedSummoner {
            RecordView(matches: viewModel.matches, summoner: summoner)
                .padding(.horizontal, 10)
                .padding(.bottom, registerButtonHeight)
        }
    }
    
    @ViewBuilder
    private func keyboardButton() -> some View {
        HStack {
            
            Button {
                focusState = nil
            } label: {
                Text("종료")
            }

            Button {
                Task { await viewModel.buttonTapped() }
                focusState = nil
            } label: {
                Text("검색")
            }
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    @ViewBuilder
    private func hiddenTitle(safeAreaTop: CGFloat) -> some View {
        if let summoner = viewModel.searchedSummoner {
            HiddenTitle(spaceName: self.spaceName, headerHeight: 50, topSafeArea: safeAreaTop) {
                HStack {
                    viewModel.emblemImage
                        .resizable()
                        .frame(maxWidth: 50, maxHeight: 50)
                    
                    Text("\(summoner.name)")
                }
                .padding(.top, safeAreaTop)
                .frame(maxWidth: .infinity, maxHeight: 50 + safeAreaTop)
                .background(Color.white)
                .offset(y: -safeAreaTop)
                .onTapGesture {
                    self.focusState = .summonerName
                }
            }
        }
    }
}

struct RegisterSummonerView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterSummonerView()
    }
}
