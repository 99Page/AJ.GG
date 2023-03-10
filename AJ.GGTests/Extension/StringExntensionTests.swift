//
//  StringExntensionTests.swift
//  AJ.GGTests
//
//  Created by 노우영 on 2023/01/05.
//

import XCTest
@testable import AJ_GG

final class StringExntensionTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testTier() {
        
        let tierStrings: [String] = ["IRON", "BRONZE", "SILVER", "GOLD", "PLATINUM",
                                     "DIAMOND", "MASTER", "GRANDMASTER", "CHALLENGER",
                                     "WOOD", "SEA", "SKY"]
        
        let expectedTiers: [Tier?] = [.iron, .bronze, .silver, .gold, .platinum,
                                .diamond, .master, .grandmaster, .challenger,
                                 nil, nil, nil]
        
        for i in 0..<tierStrings.count {
            let actual = Tier(tierStrings[i])
            let expected = expectedTiers[i]
            XCTAssertEqual(actual, expected)
        }
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
