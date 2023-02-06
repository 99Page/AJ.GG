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
    let serverError: ServerError?
    
    var message: String {
        serverError?.meesage ?? ""
    }
    
    var statusCode: Int {
        serverError?.statusCode ?? 200
    }
}

struct ServerError: Codable, Error {
    let status: ServerDecoding
    
    var meesage: String {
        status.message
    }
    
    var statusCode: Int {
        status.statusCode
    }
}

struct ServerDecoding: Codable {
    let message: String
    let statusCode: Int

    enum CodingKeys: String, CodingKey {
        case message
        case statusCode = "status_code"
    }
}


