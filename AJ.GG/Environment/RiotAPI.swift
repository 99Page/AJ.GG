//
//  RiotAPIKey.swift
//  AJ.GG
//
//  Created by 노우영 on 2022/12/26.
//

import Foundation

let RIOT_API_KEY = "RGAPI-352de047-e756-447f-82f9-48488c9f428e"
let BASE_URL = "api.riotgames.com"
let AUTH_KEY = "X-Riot-Token"
let RIOT_API_URL = "https://KR.\(BASE_URL)"

enum Region: String {
    case br1, enu1, euw1, jp1, kr, la1, la2, na1, oc1, tr1, ru 
}
