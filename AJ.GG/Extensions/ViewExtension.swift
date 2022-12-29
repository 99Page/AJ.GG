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
}
