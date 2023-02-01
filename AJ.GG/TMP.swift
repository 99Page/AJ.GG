//
//  TMP.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/02/01.
//

import SwiftUI

struct TMP: View {
    
    @State private var haptic: Bool = false
   var body: some View {
       Image(systemName: "applelogo")
           .resizable()
           .frame(width: 100, height: 100)
           .offset(x: haptic ? -15 : 0)
           .animation(.spring(), value: haptic)
           .onTapGesture {
               haptic.toggle()
           }
           
           
       
   }
}

struct TMP_Previews: PreviewProvider {
    static var previews: some View {
        TMP()
    }
}
