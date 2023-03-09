//
//  ServiceInjector.swift
//  AJ.GG
//
//  Created by 노우영 on 2023/03/09.
//

import Foundation

protocol ServiceProtocol {
    
}

protocol ServiceInjectorProtocol {
    associatedtype ServiceType
    var dependency: ServiceType { get }
    static func select(service: ServiceType) -> ServiceType
}

enum SummonerServiceInjector: String, ServiceInjectorProtocol {
    
    case failure
    case success
    
    var dependency: SummonerServiceEnabled {
        switch self {
        
        case .failure:
            return MockSummonerServiceFailure()
        case .success:
            return MockSummonerSerivceSuccess()
        }
    }
    
    static func select(service: SummonerServiceEnabled) -> SummonerServiceEnabled {
           if let variable = ProcessInfo.processInfo.environment["-SummonerService"] {
               return SummonerServiceInjector(rawValue: variable)?.dependency ?? service
           } else {
               return service
           }
       }
}

enum LeagueV4ServiceInjector: String, ServiceInjectorProtocol {
    case failure
    case success
    
    var dependency: LeagueV4ServiceEnabled {
        switch self {
        case .failure:
            return MockLeagueV4ServiceFailure()
        case .success:
            return MockLeagueV4ServiceSuccess()
        }
    }
    
    static func select(service: LeagueV4ServiceEnabled) -> LeagueV4ServiceEnabled {
           if let variable = ProcessInfo.processInfo.environment["-LeagueV4Service"] {
               return LeagueV4ServiceInjector(rawValue: variable)?.dependency ?? service
           } else {
               return service
           }
       }
}

enum MatchV5ServiceInjector: String, ServiceInjectorProtocol {
    case failure
    case success
    
    var dependency: MatchV5ServiceEnabled {
        switch self {
        case .failure:
            return MockMatchV5ServiceFailure()
        case .success:
            return MockMatchV5ServiceSuccess()
        }
    }
    
    static func select(service: MatchV5ServiceEnabled) -> MatchV5ServiceEnabled {
           if let variable = ProcessInfo.processInfo.environment["-MatchV5Service"] {
               return MatchV5ServiceInjector(rawValue: variable)?.dependency ?? service
           } else {
               return service
           }
       }
}
