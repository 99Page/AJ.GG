//
//  ObjectiveDTO.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/10.
//

import Foundation

struct ObjectivesDTO: Codable {
    let baron, champion, dragon, inhibitor: ObjectiveDTO
    let riftHerald, tower: ObjectiveDTO
}

struct ObjectiveDTO: Codable {
    let first: Bool
    let kills: Int
}
