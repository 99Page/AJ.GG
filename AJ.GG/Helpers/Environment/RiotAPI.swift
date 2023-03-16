//
//  RiotAPIKey.swift
//  AJ.GG
//
//  Created by 노우영 on 2022/12/26.
//

import Foundation

let BASE_URL = "api.riotgames.com"
let RIOT_API_URL = "https://KR.\(BASE_URL)"

enum RiotAuth: String {
    case key = "X-Riot-Token"
    case value = "RGAPI-b14afcd7-88a5-4f03-9d30-803ccd8fa6db"
}

enum RiotURL {
    
    static let BASE_URL: String = "api.riotgames.com"
    static let IMAGE_URL: String = "http://ddragon.leagueoflegends.com/cdn/13.1.1/img"
    
    case base(region: Region)
    case championSquareAsset(champion: String)
    case profileIcon(_ profileIconID: Int)
    
    var url: String {
        switch self {
        case .championSquareAsset(let champion):
            if champion.isEqual(str: "Poro") {
                return "http://ddragon.leagueoflegends.com/cdn/13.1.1/img/profileicon/685.png"
            }
            return "\(RiotURL.IMAGE_URL)/champion/\(champion).png"
        case .base(let region):
            return "https://\(region.rawValue).api.riotgames.com"
        case .profileIcon(let profileIconID):
            return "\(RiotURL.IMAGE_URL)/profileicon/\(profileIconID).png"
        }
    }
}

enum IconID: Int {
    case piratePoro = 3493
}

enum Region: String {
    case br1, enu1, euw1, jp1, kr, la1, la2, na1, oc1, tr1, ru, asia
}
