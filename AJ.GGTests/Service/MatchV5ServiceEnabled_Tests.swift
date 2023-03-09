//
//  MatchV5ServiceEnabled_Tests.swift
//  AJ.GGTests
//
//  Created by 노우영 on 2023/03/09.
//

import XCTest
@testable import AJ_GG

final class MatchV5ServiceEnabled_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_MockMatchV5ServcieSuccess_searchMatchDTOsWhereRankGameByPuuid_doesReturnSuccess() async {
        //  Given
        let service: MatchV5ServiceEnabled = MockMatchV5ServiceSuccess()
        let expectation = XCTestExpectation()
        
        //  When
        let result = await service.searchMatchDTOsWhereRankGameByPuuid(puuid: "111")
        
        
        //  Then
        switch result {
        case .success(_):
            expectation.fulfill()
        case .failure(let err):
            XCTFail(err.localizedDescription)
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func test_MockMatchV5ServcieFailure_searchMatchDTOsWhereRankGameByPuuid_doesReturnFailure() async {
        //  Given
        let service: MatchV5ServiceEnabled = MockMatchV5ServiceFailure()
        let expectation = XCTestExpectation()
        
        //  When
        let result = await service.searchMatchDTOsWhereRankGameByPuuid(puuid: "111")
        
        
        //  Then
        switch result {
        case .success(_):
            XCTFail()
        case .failure(_):
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
}
