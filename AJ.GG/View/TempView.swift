//
//  TempView.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/04/12.
//

import SwiftUI

struct TempView: View {
    
    @EnvironmentObject var pathViewModel: PathViewModel
    var body: some View {
        Button {
            pathViewModel.path.removeLast(2)
        } label: {
            Text("Home")
        }

    }
}

struct TempView_Previews: PreviewProvider {
    static var previews: some View {
        TempView()
    }
}
