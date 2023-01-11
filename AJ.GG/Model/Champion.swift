////
////  Champion.swift
////  AJ.GG
////
////  Created by 노우영 on 2023/01/10.
////
//
//import Foundation
//
//struct Champion: Codable {
//    let type: TypeEnum
//    let format: String
//    let version: Version
//    let data: [String: Datum]
//}
//
//// MARK: - Datum
//struct Datum: Codable {
//    let version: Version
//    let id, key, name, title: String
//    let blurb: String
//    let info: Info
//    let image: Image
//    let tags: [Tag]
//    let partype: String
//    let stats: [String: Double]
//}
//
//// MARK: - Image
//struct Image: Codable {
//    let full: String
//    let sprite: Sprite
//    let group: TypeEnum
//    let x, y, w, h: Int
//}
//
//enum TypeEnum: String, Codable {
//    case champion = "champion"
//}
//
//enum Sprite: String, Codable {
//    case champion0PNG = "champion0.png"
//    case champion1PNG = "champion1.png"
//    case champion2PNG = "champion2.png"
//    case champion3PNG = "champion3.png"
//    case champion4PNG = "champion4.png"
//    case champion5PNG = "champion5.png"
//}
//
//// MARK: - Info
//struct Info: Codable {
//    let attack, defense, magic, difficulty: Int
//}
//
//enum Tag: String, Codable {
//    case assassin = "Assassin"
//    case fighter = "Fighter"
//    case mage = "Mage"
//    case marksman = "Marksman"
//    case support = "Support"
//    case tank = "Tank"
//}
//
//enum Version: String, Codable {
//    case the12231 = "12.23.1"
//}
