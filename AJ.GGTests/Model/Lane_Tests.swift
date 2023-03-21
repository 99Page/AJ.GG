//
//  Lane_Tests.swift
//  AJ.GGTests
//
//  Created by 노우영 on 2023/03/21.
//

import XCTest
@testable import AJ_GG

final class Lane_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_Lane_equatable() {
        let lane: Lane = .top
        let lane2: Lane = .top
        let lane3: Lane = .mid
        
        XCTAssertTrue(lane == lane2)
        XCTAssertFalse(lane == lane3)
    }
    

}
