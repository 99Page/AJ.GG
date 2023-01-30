//
//  HiddenTitle.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/27.
//

import SwiftUI

struct HiddenTitle<Content: View>: View {
    
    let spaceName: String
    let headerHeight: CGFloat
    let safeAreaTop: CGFloat
    let content: () -> Content
    
    init(spaceName: String, headerHeight: CGFloat, topSafeArea: CGFloat, content: @escaping () -> Content) {
        self.spaceName = spaceName
        self.headerHeight = headerHeight
        self.safeAreaTop = topSafeArea
        self.content = content
    }
    
    
    var body: some View {
        GeometryReader { proxy in
            let offset = proxy.frame(in: .named(spaceName)).minY
            let defaultOffset = safeAreaTop + headerHeight
            let progess = -offset  / (defaultOffset + headerHeight)
            let headerOffset = (offset < 0 ? -offset : -defaultOffset)
            
            content()
                .offset(y: headerOffset)
                .opacity(progess)
        }
    }
}
