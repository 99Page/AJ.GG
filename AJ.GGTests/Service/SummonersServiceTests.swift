//
//  SummonersServiceTests.swift
//  AJ.GGTests
//
//  Created by 노우영 on 2022/12/29.
//

import XCTest
@testable import AJ_GG

final class SummonersServiceTests: XCTestCase {
    
    var service: SummonerServiceEnable!
    
    override func setUpWithError() throws {
        service = SummonerService()
    }

    override func tearDownWithError() throws {
        service = nil
    }
    
    func testSummonerByNameForMyName() async {
        let expectation = XCTestExpectation()
        
        let mySummonerName = "오누영"
        let response = await service.summonerByName(summonerName: mySummonerName)
        
        if response.error != nil {
            XCTFail("SummonerByNameForMyName Fail")
        }
        
        expectation.fulfill()
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testSummonerByNameForNotExistsname() async {
        let expectation = XCTestExpectation()
        
        let notExistedName = "오1누1영"
        let response = await service.summonerByName(summonerName: notExistedName)
        
        if response.error == nil {
            XCTFail("SummonerByName Fail")
        }
        
        expectation.fulfill()
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
