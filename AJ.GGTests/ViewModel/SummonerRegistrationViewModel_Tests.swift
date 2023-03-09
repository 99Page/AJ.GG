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
    
    func test_SummonerRegistrationViewModel_leagueTier_shoudBeNil() {
        //  Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        //  When
        
        //  Then
        XCTAssertNil(vm.leagueTier)
    }
    
    func test_SummonerRegistrationViewModel_searchButtonTapped_doesSetSummoner() async {
        //  Given
        let vm = SummonerRegistrationViewModel(summonerService: MockSummonerSerivceSuccess(),
                                               leagueV4Service: MockLeagueV4ServiceSuccess())
        
        vm.summonerName = "SwiftUI 4"
        
        //  When
        await vm.searchButtonTapped()
        
        //  Then
        XCTAssertNotNil(vm.summoner)
    }
    
    func test_SummonerRegistrationViewModel_searchButtonTapped_doesSetLeagueTier() async {
        //  Given
        let vm = SummonerRegistrationViewModel(summonerService: MockSummonerSerivceSuccess(),
                                               leagueV4Service: MockLeagueV4ServiceSuccess())
        
        vm.summonerName = "SwiftUI 4"
        
        //  When
        await vm.searchButtonTapped()
        
        //  Then
        XCTAssertNotNil(vm.leagueTier)
    }
    
    
    func test_SummonerRegistrationViewModel_searchButtonTapped_summonerShouldBeNil() async {
        //  Given
        let vm = SummonerRegistrationViewModel(summonerService: MockSummonerSerivceSuccess(),
                                               leagueV4Service: MockLeagueV4ServiceSuccess())
        
        vm.summonerName = "SwiftUI 4"
        await vm.searchButtonTapped()
        vm.summonerName = ""
        
        //  When
        await vm.searchButtonTapped()
        
        //  Then
        XCTAssertNil(vm.summoner)
    }
}
