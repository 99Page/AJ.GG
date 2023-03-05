//
//  RegisterVIewModelTests.swift
//  AJ.GGTests
//
//  Created by 노우영 on 2023/02/06.
//

import XCTest
@testable import AJ_GG

final class RegisterVIewModelTests: XCTestCase {

    var viewModel: RegisterSummonerViewModel?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = RegisterSummonerViewModel(summonerService: <#T##SummonerServiceEnable#>,
                                              leagueV4Service: <#T##LeagueV4ServiceEnable#>,
                                              matchV5Service: <#T##MatchV5ServiceEnable#>)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_RegisterViewModel_searchSummoner_doesReturnValidValue() {
        
    }
    
    func test_RegisterViewModel_searchSummoner_() {
        
    }
    
    func test_RegisterViewModel_searchSummoner123() {
        
    }
    
    func test_RegisterViewModel_searchSummoner12() {
        
    }
    
    func test_RegisterViewModel_searchSummoner3() {
        
    }
    
    func test_RegisterViewModel_searchSummoner4() {
        
    }
}
