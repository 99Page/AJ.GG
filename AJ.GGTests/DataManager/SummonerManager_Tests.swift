//
//  SummonerManager_Tests.swift
//  AJ.GGTests
//
//  Created by 노우영 on 2023/03/15.
//

import XCTest
@testable import AJ_GG

final class SummonerManager_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_SummonerManager_addSummoner_shouldAddSummoner() {
        //  Given
        let summonerManager = CDSummonerManager(container: PersistentContainerInjector.empty.container)
        let summoner = Summoner.dummyData()
        let leagueTier = LeagueTier.dummyData()
        
        //  When
        summonerManager.addSummoner(summoner: summoner, leagueTier: leagueTier)
        
        //  Then
        if let fetchedSummoner = summonerManager.fetchAll().first {
            XCTAssertEqual(summoner, Summoner(cdSummoner: fetchedSummoner))
        } else {
            XCTFail()
        }
    }

}
