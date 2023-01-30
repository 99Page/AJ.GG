//
//  Loader.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/30.
//

import SwiftUI

struct Loader: View {
    @State private var rotation = 0.0

       var body: some View {
           Image(systemName: "arrow.2.circlepath")
               .resizable()
               .aspectRatio(contentMode: .fit)
               .frame(width: 50, height: 50)
               .rotationEffect(.degrees(rotation))
               .animation(.linear(duration: 2.0).repeatForever(autoreverses: false), value: rotation)
               .onAppear {
                   self.rotation = 360
               }
       }
}

struct Loader_Previews: PreviewProvider {
    static var previews: some View {
        Loader()
    }
}
