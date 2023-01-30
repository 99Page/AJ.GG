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
                PGVStack {
                    Text("Profile View")
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
