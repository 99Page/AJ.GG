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
                                                                   leagueV4Service: LeagueV4Serivce())
    @FocusState private var focusState: Field?
    
    var isSummonerNameFocused: Bool{
        focusState == .summonerName
    }
    
    var body: some View {
        VStack {
            CapsuleText(text: $viewModel.summonerName,
                        title: viewModel.title)
                .padding(.horizontal, 30)
                .focused($focusState, equals: .summonerName)
                .animation(.easeIn(duration: 0.4), value: isSummonerNameFocused)
            
            HStack {
                ForEach(0..<viewModel.summoners.count, id: \.self) { i in
                    Text("\(viewModel.summoners[i].summonerName ?? "이름")")
                }
            }
            
            if let tier = viewModel.tier {
                SwiftUI.Image(tier.emblem)
                    .resizable()
            }
            
            
            Spacer()
            
            Button {
                Task {
                    await viewModel.buttonTapped()
                }
            } label: {
                Text("검색")
            }
            
            Button {
                viewModel.deleteSummonersAll()
            } label: {
                Text("삭제")
            }

            
        }
        .hidden(viewModel.isSummonerRegistered)
        .onTapGesture {
            self.focusState = nil
        }
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                Button {
                    Task { await viewModel.buttonTapped() }
                    focusState = nil
                } label: {
                    Text("완료")
                }
                .frame(maxWidth: .infinity, alignment: .trailing)

            }
        }
    }
}

struct RegisterSummonerView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterSummonerView()
    }
}
