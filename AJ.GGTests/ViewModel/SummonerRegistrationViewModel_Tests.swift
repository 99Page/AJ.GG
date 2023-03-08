//
//  SummonerRegistrationViewModel_Tests.swift
//  AJ.GGTests
//
//  Created by 노우영 on 2023/03/08.
//

import XCTest
@testable import AJ_GG

final class SummonerRegistrationViewModel_Tests: XCTestCase {
    
    var viewModel: SummonerRegistrationViewModel?
    
    override func setUpWithError() throws {
        viewModel = SummonerRegistrationViewModel(summonerService: SummonerService(),
                                                  leagueV4Service: LeagueV4Serivce())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func test_SummonerRegistrationViewModel_summonerName_shouldBeEmpty() {
        //  Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        //  When
        
        //  Then
        XCTAssertTrue(vm.summonerName.isEmpty)
    }
    
    
    func test_SummonerRegistrationViewModel_summoner_shouldBeNil() {
        //  Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        //  When
        
        //  Then
        XCTAssertNil(vm.summoner)
    }
    
    func test_SummonerRegistrationViewModel_matches_shouldBeEmpty() {
        //  Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        //  When
        
        //  Then
        XCTAssertTrue(vm.matches.isEmpty)
    }
    
    func test_SummonerRegistrationViewModel_searchButtonTapped_shouldBeEmpty() async {
        //  Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        vm.summonerName = ""
        
        //  When
        await vm.searchButtonTapped()
        
        //  Then
        XCTAssertNil(vm.summoner)
        XCTAssertTrue(vm.matches.isEmpty)
    }
}
