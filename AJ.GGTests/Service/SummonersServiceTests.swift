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
    let mySummonerName = "SwiftUI 4"
    let nameDoesNotExist = "SwiftUI 5"
    
    override func setUpWithError() throws {
        service = SummonerService()
    }

    override func tearDownWithError() throws {
        service = nil
    }
    
    func testSummonerByNameForMyName() async {
        
        let start = CFAbsoluteTimeGetCurrent()
        let expectation = XCTestExpectation()
        let response = await service.summonerByName(summonerName: mySummonerName)
        
        switch response {
        case .success(_):
            break
        case .failure(let failure):
            XCTFail("\(failure.localizedDescription)")
        }
        
        let end = CFAbsoluteTimeGetCurrent()
        let timeInterval = end - start
        print("\(timeInterval)")
        expectation.fulfill()
        wait(for: [expectation], timeout: 1.0)
        
        
    }
    
    func testSummonerByNameForNotExistsname() async {
        let expectation = XCTestExpectation()
        let response = await service.summonerByName(summonerName: nameDoesNotExist)
        
        switch response {
        case .success(_):
            XCTFail("XCTFail")
        case .failure(let failure):
            print("\(failure)")
            break
        }
        
        expectation.fulfill()
        wait(for: [expectation], timeout: 1.0)
    }
}
