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
        let summoner = Summoner.dummyTopmMatch()
        let leagueTier = LeagueTier.dummyTopmMatch()
        
        //  When
        summonerManager.addSummoner(summoner: summoner, leagueTier: leagueTier)
        
        //  Then
        if let fetchedSummoner = summonerManager.fetchAll().first {
            XCTAssertEqual(summoner, Summoner(cdSummoner: fetchedSummoner))
        } else {
            XCTFail()
        }
    }
    
    
    func test_SummonerManager_deleteAll_shouldDeleteEverySummoner() {
        //  Given
        let summonerManager = CDSummonerManager(container: PreviewPersistentContainer.shared)
        let matchManager = CDMatchManager(container: PreviewPersistentContainer.shared)
        let test = summonerManager.fetchAll()
        guard let summoner = test.first else {
            XCTFail("Preview Data Error")
            return
        }
        
        XCTAssertFalse(test.isEmpty)
        let checkMatch = matchManager.fetchBySummoner(sumonerEntity: summoner).isEmpty
        XCTAssertFalse(checkMatch)
        
        //  When
        summonerManager.deleteAll()
        
        //  Then
        let actual = summonerManager.fetchAll()
        XCTAssertTrue(actual.isEmpty)
        
        let isMatchEmpty = matchManager.fetchBySummoner(sumonerEntity: summoner).isEmpty
        XCTAssertTrue(isMatchEmpty)
    }

}
