//
//  ServerError.swift
//  AJ.GG
//
//  Created by 노우영 on 2022/12/26.
//

import Foundation
import Alamofire

struct NetworkError: Error {
    let AFError: AFError?
    let status: ServerError?
}

struct ServerError: Codable {
    let message: String
    let statusCode: Int

    enum CodingKeys: String, CodingKey {
        case message
        case statusCode = "status_code"
    }
}

