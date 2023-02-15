//
//  MatchV5ServiceTests.swift
//  AJ.GGTests
//
//  Created by 노우영 on 2023/02/13.
//

import XCTest
@testable import AJ_GG

final class MatchV5ServiceTests: XCTestCase {
    
    var matchV5Service: MatchV5ServiceEnable!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMockService() async {
        self.matchV5Service = MockMatchV5Service()
        let result = await matchV5Service.searchMatchDTOsWhereRankGameByPuuid(puuid: "123")
    }

}
