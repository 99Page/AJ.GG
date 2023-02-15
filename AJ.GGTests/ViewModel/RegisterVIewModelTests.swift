////
////  RegisterVIewModelTests.swift
////  AJ.GGTests
////
////  Created by 노우영 on 2023/02/06.
////
//
//import XCTest
//@testable import AJ_GG
//
//final class RegisterVIewModelTests: XCTestCase {
//
//    var viewModel: RegisterSummonerViewModel!
//
//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//        viewModel = RegisterSummonerViewModel(summonerService: SummonerService(), leagueV4Service: LeagueV4Serivce(), matchV5Service: MatchV5Service(), summonerManager: SummonerManager(inPreview: true))
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testRegistetButtonTappedWhenSummonerDoesNotSearched() {
//        let expectation = XCTestExpectation()
//
//        self.viewModel.deleteSummonersAll()
//        self.viewModel.registerButtonTapped()
//        self.viewModel.fetchSummonersAll()
//
//        let expected: Int = 0
//        let actual = viewModel.summoners.count
//
//        XCTAssertEqual(expected, actual)
//
//    }
//    
//    func testRegistetButtonTappedWhenSummonerSearched() {
//        let expectation = XCTestExpectation()
//
//        self.viewModel.deleteSummonersAll()
//
//        self.viewModel.searchedSummoner = SummonerDTO(id: "123", accountID: "213", puuid: "123", name: "SwiftUI", profileIconID: 123, revisionDate: 123, summonerLevel: 123)
//        self.viewModel.tier = LeagueTier(tier: Tier.diamond, rank: Rank.ii, points: 30)
//
//        self.viewModel.registerButtonTapped()
//        self.viewModel.fetchSummonersAll()
//
//        let expected: Int = 1
//        let actual = viewModel.summoners.count
//
//        XCTAssertEqual(expected, actual)
//
//    }
//
//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        // Any test you write for XCTest can be annotated as throws and async.
//        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
//        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
//
//}
