//
//  RegisterSummonerView.swift
//  AJ.GG
//
//  Created by 노우영 on 2022/12/26.
//

import SwiftUI

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
            
            
            Spacer()
                .hidden(!isSummonerNameFocused)
            
            if let tier = viewModel.tier {
                Image(tier.emblem)
                    .resizable()
            }
            
            Button {
                Task {
                    await viewModel.buttonTapped()
                }
            } label: {
                Text("버튼")
            }

            
        }
        .onTapGesture {
            self.focusState = nil
        }
    }
}

struct RegisterSummonerView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterSummonerView()
    }
}
