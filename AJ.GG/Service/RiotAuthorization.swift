//
//  AuthorizationProtocol.swift
//  AJ.GG
//
//  Created by 노우영 on 2022/12/29.
//

import Foundation
import Alamofire

class RiotAuthorizaiton {
    let headers: HTTPHeaders = [ AUTH_KEY : RIOT_API_KEY ]
    
    func url(region: Region) -> String {
        return "https://\(region.rawValue).\(BASE_URL)"
    }
}
