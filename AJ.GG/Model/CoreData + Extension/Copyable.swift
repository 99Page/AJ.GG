//
//  Copyable.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/24.
//

import Foundation

protocol Copyable {
    associatedtype Data
    func copy(_ origin: Data) 
}
