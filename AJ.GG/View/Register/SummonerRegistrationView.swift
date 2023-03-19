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
    
    @StateObject private var
    viewModel = SummonerRegistrationViewModel(summonerService: SummonerService(),
                                              leagueV4Service: LeagueV4Serivce(),
                                              matchV5Service: MatchV5Service(),
                                              container: PersistentContainer.shared)
    
    @FocusState private var focusState: Field?
    let registerButtonHeight: CGFloat = 50


    var body: some View {
        VStack {
            TextField(viewModel.title, text: $viewModel.summonerName)
                .font(.system(size: 15, weight: .heavy))
                .focused($focusState, equals: .summonerName)
                .onSubmit {
                    Task {
                        await viewModel.searchButtonTapped()
                    }
                }
                .accessibilityIdentifier("SummonerNameText")
                .submitLabel(.search)
                .alert(isPresented: $viewModel.isPresented) {
                    Alert(title: Text("소환사 이름을 확인해주세요"))
                }
                .roundedRectangle(color: .gray)
            
            Button {
                Task { await viewModel.searchButtonTapped() }
            } label: {
                Text("검색하기")
                    .font(.system(size: 15, weight: .heavy))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.blue)
                    .roundedRectangle(color: .blue)
            }
            .accessibilityIdentifier("SearchButton")
            .navigationDestination(isPresented: $viewModel.goToNextView) {
                SummonerRecordView(viewModel: viewModel)
            }

            
        }
        .onAppear {
            self.focusState = .summonerName
            viewModel.clear()
        }
    }
}

struct RegisterSummonerView_Previews: PreviewProvider {
    static var previews: some View {
        SummonerRegistrationView()
    }
}
