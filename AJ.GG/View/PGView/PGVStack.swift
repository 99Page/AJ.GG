//
//  PGVStack.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/27.
//

import SwiftUI

struct PGVStack<Content> : View where Content: View {
    
    let alignment: HorizontalAlignment
    let spacing: CGFloat
    let content: Content
    
    init(alignment: HorizontalAlignment = .center, spacing: CGFloat = 10, @ViewBuilder content: () -> Content) {
        self.alignment = alignment
        self.spacing = spacing
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: alignment, spacing: spacing) {
            content
        }
        .padding(.top, 1)
    }
}

struct PGVStack_Previews: PreviewProvider {
    static var previews: some View {
        PGVStack {
            Text("텍스트")
        }
    }
}
