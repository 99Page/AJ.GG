//
//  ProfileViewModelTests.swift
//  AJ.GGTests
//
//  Created by 노우영 on 2023/02/13.
//

import XCTest
@testable import AJ_GG

final class ProfileViewModelTests: XCTestCase {
    
    var viewModel: ProfileViewModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let matchManager = MatchManager(inPreview: true)
        matchManager.deleteAll()
        let count = matchManager.fetchAll().count
        print("데이터의 수 : \(count)")
        
        viewModel = ProfileViewModel(summonerManager: SummonerManager(inPreview: true),
                                     matchManager: MatchManager(inPreview: true),
                                     matchV5Service: MockMatchV5Service())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }
    
    func testMatchV5Service() async {
        let result = await viewModel.matchV5Service.searchMatchDTOsWhereRankGameByPuuid(puuid: "1231323")
        switch result {
        case .success(let dtos):
            let count = dtos.count
            let rankGame = dtos.filter { $0.isRankGame }
            let expectation = rankGame.count
            let actual = viewModel.matchManager.fetchAll().count
            
            print("전체 수 : \(count) 랭크게임 수 : \(expectation) 저장된 수 : \(actual)")
            print("\(viewModel.matches)")
        case .failure(let failure):
            break
        }
    }
}
