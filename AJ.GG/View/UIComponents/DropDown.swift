//
//  DropDown.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/02/04.
//

import SwiftUI

struct DropDown: View {
    
    
    @State private var expandView: Bool = false
    @Binding var selection: String
    
    var content: [String]
    var activeTint: Color
    var inActiveTint: Color
    var dynamic: Bool = true
    
    var contentHeight: CGFloat {
        expandView ? CGFloat(content.count) * 55 : 55
    }
    
    var dropDownOffsetY: CGFloat {
        dynamic ? (CGFloat(content.firstIndex(of: selection) ?? 0) * -55) : 0
    }
    
    var maskOffsetY: CGFloat {
        dynamic && expandView ? (CGFloat(content.firstIndex(of: selection) ?? 0) * -55) : 0
    }
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            VStack(spacing: 0) {
                if !dynamic {
                    RowView(selection, size)
                }
                ForEach(content.filter {
                    dynamic ? true : $0 != selection
                }, id: \.self) { title in
                    RowView(title, size)
                }
            }
            .background {
                Rectangle()
                    .fill(inActiveTint)
            }
            .offset(y: dropDownOffsetY)
        }
        .frame(height: 55)
        .overlay(alignment: .trailing) {
            Image(systemName: "chevron.up.chevron.down")
                .padding(.trailing, 10)
        }
        .mask(alignment: .top) {
            Rectangle()
                .frame(height: contentHeight)
                .offset(y: maskOffsetY)
        }
    }
    
    @ViewBuilder
    func RowView(_ title: String, _ size: CGSize) -> some View {
        Text(title)
            .font(.title3)
            .fontWeight(.semibold)
            .padding(.horizontal)
            .frame(width: size.width, height: size.height, alignment: .leading)
            .background {
                if selection.isEqual(str: title) {
                    Rectangle()
                        .fill(activeTint)
                        .transition(.identity)
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation(
                    .interactiveSpring(response: 0.6,
                                       dampingFraction: 0.7,
                                       blendDuration: 0.7)) {
                   if expandView {
                       expandView = false
                       if dynamic {
                           selection = title
                       } else {
                           DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                               selection = title
                           }
                       }
                   } else {
                       if selection.isEqual(str: title) {
                           expandView = true
                       }
                   }
                }
            }
    }
}
