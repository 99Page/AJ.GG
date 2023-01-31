//
//  DummyCretable.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/26.
//

import Foundation

protocol DummyCreatable {
    associatedtype Dummy
    
    static func dummyData() -> Dummy
    static func dummyDatas() -> [Dummy]
}
