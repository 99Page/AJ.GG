//
//  MatchManager_Tests.swift
//  AJ.GGTests
//
//  Created by 노우영 on 2023/03/16.
//

import XCTest
@testable import AJ_GG

final class MatchManager_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_MatchManager_add_shouldAddMatch() async{
        //  Given
        let matchManager = CDMatchManager(container: PersistentContainerInjector.pre.container)
        let summonerManager = CDSummonerManager(container: PersistentContainerInjector.pre.container)
        let summonerEntities = summonerManager.fetchAll()
        
        if let summoner = summonerEntities.first {
            let matcheEntitis = matchManager.fetchBySummoner(sumonerEntity: summoner)
            
            var matches: [Match] = []
            switch await MockMatchV5ServiceSuccess().searchMatchDTOsWhereRankGameByPuuid(puuid: "123") {
            case .success(let values) :
                matches = values.map { Match($0, puuid: "123")}
            case .failure(_):
                XCTFail()
            }
            
            //  When
            matchManager.add(summonerEntity: summoner, match: matches[0])
            let result = matchManager.fetchBySummoner(sumonerEntity: summoner).count
            
            //  Then
            XCTAssertEqual(matcheEntitis.count + 1, result)
        } else {
            XCTFail()
        }
        
    }

}
