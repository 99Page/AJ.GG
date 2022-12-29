//
//  CapsuleText.swift
//  AJ.GG
//
//  Created by 노우영 on 2022/12/26.
//

import SwiftUI

struct CapsuleText: View {
    
    @Binding var text: String
    let title: String
    
    var body: some View {
        TextField(title, text: $text)
            .multilineTextAlignment(.center)
            .font(.system(size: 20, weight: .heavy))
            .frame(maxWidth: .infinity, minHeight: 50)
            .background(
                Capsule().stroke(lineWidth: 2)
            )
    }
}

struct CapsuleText_Previews: PreviewProvider {
    static var previews: some View {
        CapsuleText(text: .constant("텍스트"), title: "타이틀")
    }
}
