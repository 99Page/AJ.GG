//
//  HomeView.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/02.
//

import SwiftUI

struct ProfileView: View {

//    @StateObject var viewModel: ProfileViewModel = ProfileViewModel(matchV5Service: MatchV5Service())
    
    let lanes = Lane.selectableLanes()

    var body: some View {
        VStack {
            
            HStack(alignment: .center) {
                SummonerProfiles(summoners: Summoner.dummyDatas())
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            
            ScrollView {
                PGVStack {
                    HStack {
                        ForEach(lanes, id: \.rawValue) { lane in
                            LaneImage(lane: lane)
                        }
                    }
                    .padding(.horizontal, 80)
                    Text("Profile View")
                }
            }
            .padding(.top)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
