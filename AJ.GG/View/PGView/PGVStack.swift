////
////  PGVStack.swift
////  AJ.GG
////
////  Created by 노우영 on 2023/01/27.
////
//
//import SwiftUI
//
//struct PGVStack<Content: View> : View {
//    
//    
//    init(@ViewBuilder content: @escaping () -> Content) {
//        self.content = content
//    }
//    
//    
//    var body: some View {
//        VStack {
//            content()
//        }
//        .padding(.all, 1)
//    }
//}
//
//struct PGVStack_Previews: PreviewProvider {
//    static var previews: some View {
//        PGVStack {
//            Text("텍스트")
//        }
//    }
//}
