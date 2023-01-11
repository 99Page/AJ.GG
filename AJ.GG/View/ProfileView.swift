//
//  HomeView.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/02.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var viewModel: ProfileViewModel = ProfileViewModel(matchV5Service: MatchV5Service())
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                
            }
            .overlay(alignment: .topTrailing) {
                Button {
                    print("\(String(describing: viewModel.summoners[0].summonerName))")
                } label: {
                    Image(systemName: "person.crop.circle")
                }

            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
