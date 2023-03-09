//
//  LeagueV4ServiceEnabled_Tests.swift
//  AJ.GGTests
//
//  Created by 노우영 on 2023/03/09.
//

import XCTest
@testable import AJ_GG

final class LeagueV4ServiceEnabled_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_MockLeagueV4ServiceSuccess_leagueTierBySummonerID_doesReturnSuccess() async {
        //  Given
        let service = MockLeagueV4ServiceSuccess()
        let expectaton = XCTestExpectation()
        
        //  When
        let result = await service.leagueTierBySummonerID(summonerID: "123")
        
        //  Then
        switch result {
        case .success(_):
            expectaton.fulfill()
        case .failure(_):
            XCTFail()
        }
        
        wait(for: [expectaton], timeout: 1)
    }
    
    func test_MockLeagueV4ServiceSuccess_leagueTierBySummonerID_doesReturnFailure() async {
        //  Given
        let service = MockLeagueV4ServiceFailure()
        let expectaton = XCTestExpectation()
        
        //  When
        let result = await service.leagueTierBySummonerID(summonerID: "123")
        
        //  Then
        switch result {
        case .success(_):
            XCTFail()
        case .failure(_):
            expectaton.fulfill()
        }
        
        wait(for: [expectaton], timeout: 1)
    }
    
}
