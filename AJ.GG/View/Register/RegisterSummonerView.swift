//
//  RegisterSummonerView.swift
//  AJ.GG
//
//  Created by 노우영 on 2022/12/26.
//

import SwiftUI
import CoreData

struct RegisterSummonerView: View {
    
    enum Field: String, Hashable {
        case summonerName
    }
    
    @StateObject private var viewModel = RegisterSummonerViewModel(summonerService: SummonerService(),
                                                                   leagueV4Service: LeagueV4Serivce(),
                                                                   matchV5Service: MatchV5Service())
    @FocusState private var focusState: Field?
    
    let spaceName: String = "scroll"
    
    var body: some View {
        
        GeometryReader { outer in
            let safeAreaTop = outer.safeAreaInsets.top
            ScrollView {
                VStack {
                    CapsuleText(text: $viewModel.summonerName,
                                title: viewModel._title)
                        .padding(.horizontal, 30)
                        .focused($focusState, equals: .summonerName)
                        .onSubmit {
                            Task {
                                viewModel.buttonTapped
                            }
                        }
                    
                    if let summoner = viewModel.searchedSummoner {
                        RecordView(matches: viewModel.matches, summoner: summoner)
                            .padding(.horizontal, 10)
                    }
                }
                .padding(.all, 1)
                .overlay {
                    hiddenTitle(safeAreaTop: safeAreaTop)
                }
            }
            .coordinateSpace(name: self.spaceName)
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    keyboardButton()
                }
            }
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
                .frame(maxWidth: .infinity, maxHeight: 50)
                .background(Color.white)
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
