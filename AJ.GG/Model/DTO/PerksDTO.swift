//
//  PerksDTO.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/01/10.
//

import Foundation

struct PerksDTO: Codable {
    let statPerks: StatPerksDTO
    let styles: PerkStyleDTOs
}

struct StatPerksDTO: Codable {
    let defense, flex, offense: Int
}

struct PerkStyleDTO: Codable {
    let description: String
    let selections: PerkStyleSelectionDTOs
    let style: Int
}

typealias PerkStyleDTOs = [PerkStyleDTO]

struct PerkStyleSelectionDTO: Codable {
    let perk, var1, var2, var3: Int
}

typealias PerkStyleSelectionDTOs = [PerkStyleSelectionDTO]
