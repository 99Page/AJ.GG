//
//  SummonersServiceTests.swift
//  AJ.GGTests
//
//  Created by 노우영 on 2022/12/29.
//

import XCTest
@testable import AJ_GG

final class SummonersServiceTests: XCTestCase {
    
    override func setUpWithError() throws {
      
    }

    override func tearDownWithError() throws {

    }
    
    func test_MockSummonerServiceSuccess_idByName_doesReturnSuccess() async {
        
        //  Given
        let expectation = XCTestExpectation()
        let service = MockSummonerSerivceSuccess()
        
        //  When
        let result = await service.idByName(summonerName: "SwiftUI 4")
        
        
        //  Then
        switch result {
        case .success(_):
            expectation.fulfill()
        case .failure(_):
            XCTFail()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    
    func test_MockSummonerServiceSuccess_summonerByName_doesReturnSuccess() async {
        
        //  Given
        let expectation = XCTestExpectation()
        let service = MockSummonerSerivceSuccess()
        let name = "SwiftUI 4"
        
        //  When
        let result = await service.summonerByName(summonerName: name)
        
        
        //  Then
        
        switch result {
        case .success(let value):
            expectation.fulfill()
            XCTAssertEqual(value.name, name)
        case .failure(let failure):
            XCTFail(failure.localizedDescription)
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    
    func test_MockSummonerServiceFailure_idByName_doesReturnFailure() async {
        
        //  Given
        let expectation = XCTestExpectation()
        let service = MockSummonerServiceFailure()
        
        //  When
        let result = await service.idByName(summonerName: "SwiftUI 4")
        
        
        //  Then
        switch result {
        case .success(_):
            XCTFail()
        case .failure(_):
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func test_MockSummonerServiceFailure_summonerByName_doesReturnFailure() async {
        
        //  Given
        let expectation = XCTestExpectation()
        let service = MockSummonerServiceFailure()
        
        //  When
        let result = await service.summonerByName(summonerName: "SwiftUI 4")
        
        
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
