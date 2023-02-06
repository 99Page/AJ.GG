//
//  ServiceAlertEnable.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/02/06.
//

import Foundation
import SwiftUI

protocol AlertCase {
    var title: String { get }
    var message: String { get }
    var callback: () async -> () { get }
    var statusCode: Int { get }
}

struct CustomAlert {
    var titleString: String = ""
    var messageString: String = ""
    var callback: () async -> () = { }
    var isPresentedAlert: Bool = false
    var isPresentedCancelButton: Bool = false
    
    var message: Text {
        Text(messageString)
    }
    
    var title: Text {
        Text(titleString)
    }
    
    mutating func showAlertWithNetworkError(_ error: NetworkError) {
        self.titleString = error.message
    }
             
}

protocol ServiceAlertEnable {
    var alert: CustomAlert { get set }
    
    func showAlert(_ error: NetworkError)
}
