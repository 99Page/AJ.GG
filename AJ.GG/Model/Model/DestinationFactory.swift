//
//  DestinationFactory.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/04/12.
//

import SwiftUI

enum DestinationFactory: Hashable {
    case registrationView
    case recordView(Summoner)
    
    @ViewBuilder
    var view: some View {
        switch self {
        case .registrationView:
            SummonerRegistrationView()
        case .recordView(let summoner):
            SummonerRecordView(summoner: summoner)
        }
    }
}
