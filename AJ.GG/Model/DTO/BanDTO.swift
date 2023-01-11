//
//  BanDTO.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/10.
//

import Foundation

struct BanDTO: Codable {
    let championID, pickTurn: Int

    enum CodingKeys: String, CodingKey {
        case championID = "championId"
        case pickTurn
    }
}

typealias BanDTOs = [BanDTO]
