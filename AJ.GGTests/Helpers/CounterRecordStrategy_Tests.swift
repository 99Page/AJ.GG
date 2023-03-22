//
//  MyRecordStrategy_Tests.swift
//  AJ.GGTests
//
//  Created by 노우영 on 2023/03/22.
//

import XCTest
@testable import AJ_GG

final class CounterRecordStrategy_Tests: XCTestCase {

    var context = CounterRecordContext(strategy: MyCounterRecordStrategy())
    
    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_RivalCounterRecordStrategy_toDictionary_shouldReturnExpectedValues() {
        //  Given
        let strategy = RivalCounterRecordStrategy()
        let matches = Match.dummyDatas()
        
        //  When
        var dictionary = strategy.toDictionary(matches: matches)
        
        //  Then
        for match in matches {
            if match.isWin {
                dictionary[match.myChampionName]![0] -= 1
            } else {
                dictionary[match.myChampionName]![1] -= 1
            }
            
            guard let values = dictionary[match.myChampionName] else {
                XCTFail("Can`t find rivalChampionName key")
                return
            }
            
            guard values[0] >= 0 && values[1] >= 0 else {
                XCTFail("Match Record has count problem")
                return
            }
        }
    }
    
    func test_RivalCounterRecordStrategy_convertToChmampionWithRate_shouldReturnExpectedValues() {
        //  Given
        let strategy = RivalCounterRecordStrategy()
        let matches = Match.dummyDatas()
        let dictionary = strategy.toDictionary(matches: matches)
        
        //  When
        let championWithRates = strategy.convertToChampionWithRate(matches: matches)
        
        //  Then
        for (k, v) in dictionary {
            let result = championWithRates.contains {
                $0.champion.name == k && $0.win == v[0] && $0.lose == v[1]
            }
            
            XCTAssertTrue(result)
        }
    }
    
    func test_MyCounterRecordStrategy_toDictionary_shouldReturnExpectedValues() {
        //  Given
        let strategy = MyCounterRecordStrategy()
        let matches = Match.dummyDatas()
        
        //  When
        var dictionary = strategy.toDictionary(matches: matches)
        
        //  Then
        for match in matches {
            if match.isWin {
                dictionary[match.rivalChampionName]?[0] -= 1
            } else {
                dictionary[match.rivalChampionName]?[1] -= 1
            }
            
            guard let values = dictionary[match.rivalChampionName] else {
                XCTFail("Can`t find rivalChampionName key")
                return
            }
            
            guard values[0] >= 0 && values[1] >= 0 else {
                XCTFail("Match Record has count problem")
                return 
            }
        }
    }
    
    
    func test_MyCounterRecordStrategy_convertToChmampionWithRate_shouldReturnExpectedValues() {
        //  Given
        let strategy = MyCounterRecordStrategy()
        let matches = Match.dummyDatas()
        let dictionary = strategy.toDictionary(matches: matches)
        
        //  When
        let championWithRates = strategy.convertToChampionWithRate(matches: matches)
        
        //  Then
        for (k, v) in dictionary {
            let result = championWithRates.contains {
                $0.champion.name == k && $0.win == v[0] && $0.lose == v[1]
            }
            
            XCTAssertTrue(result)
        }
    }
}
