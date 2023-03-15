//
//  ViewExtension.swift
//  AJ.GG
//
//  Created by 노우영 on 2022/12/26.
//

import Foundation
import SwiftUI

extension View {
    
    @ViewBuilder
    func hidden(_ isHidden: Bool) -> some View {
        if isHidden {}
        else { self }
    }
    
    @ViewBuilder
    func frame(cgsize: CGSize, alignment: Alignment = .center) -> some View {
        self
            .frame(width: cgsize.width, height: cgsize.height, alignment: alignment)
    }
}

extension View {
    @ViewBuilder
    func keyboardHideWhenScreenTapped() -> some View {
        self
            .gesture(
                 TapGesture()
                     .onEnded { _ in
                         UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                     }
             )
    }
}

extension View {
    @ViewBuilder
    func roundedRectangle(color: Color) -> some View {
        self
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke()
                    .foregroundColor(color)
            }
            .padding(.horizontal, 30)
    }
}


