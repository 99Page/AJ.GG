//
//  HomeViewModel_Tests.swift
//  AJ.GGTests
//
//  Created by 노우영 on 2023/03/05.
//

import XCTest
import Combine
@testable import AJ_GG

final class HomeViewModel_Tests: XCTestCase {
    
    var viewModel: HomeViewModel?
    var cancellable = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_HomeViewModel_fetchSummoners_shouldBeStoredValues() {
        //  Given
        viewModel = HomeViewModel(matchV5Serivce: MockMatchV5ServiceSuccess(), containerSoruce: PreviewPersistentContainer())
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        //  When
        
        //  Then
        XCTAssertEqual(vm.summoners.count, 1)
    }
    
    
    func test_HomeViewModel_fetchSummoners_shouldBeStoredValues2() {
        //  Given
        viewModel = HomeViewModel(matchV5Serivce: MockMatchV5ServiceSuccess(), containerSoruce: EmptyPersistentContainer())
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        //  When
        
        //  Then
        XCTAssertEqual(vm.summoners.count, 0)
    }
    
    func test_HomeViewModel_isSummonerEmpty_shoudBeTrue() {
        //  Given
        viewModel = HomeViewModel(matchV5Serivce: MockMatchV5ServiceSuccess(), containerSoruce: EmptyPersistentContainer())
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        let expectation = XCTestExpectation(description: "Should Be Empty after 0.1 seconds")
        
        //  When
        vm.$isSummonerEmpty
            .dropFirst()
            .sink { value in
                expectation.fulfill()
            }
            .store(in: &cancellable)
        
        //  Then
        wait(for: [expectation], timeout: 1)
        XCTAssertTrue(vm.isSummonerEmpty)
    }
    
    func test_HomeViewModel_isSummonerEmpty_shoudBeFalse() {
        //  Given
        viewModel = HomeViewModel(matchV5Serivce: MockMatchV5ServiceSuccess(),
                                  containerSoruce: PreviewPersistentContainer.shared)
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        //  When
        
        //  Then
        XCTAssertFalse(vm.isSummonerEmpty)
    }
    
    func test_HomeViewModel_summoners_shouldBeSet() {
        //  Given
        viewModel = HomeViewModel(matchV5Serivce: MockMatchV5ServiceSuccess(),
                                  containerSoruce: PreviewPersistentContainer.shared)
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        let expectation = XCTestExpectation()
        
        //  When
        vm.$summoners
            .sink { value in
                print("sink \(value)")
                expectation.fulfill()
            }
            .store(in: &cancellable)
        
        //  Then
        wait(for: [expectation], timeout: 1)
        XCTAssertFalse(vm.summoners.isEmpty)
    }
    
    
    func test_HomeViewModel_matches_shouldBeSet() {
        //  Given
        viewModel = HomeViewModel(matchV5Serivce: MockMatchV5ServiceSuccess(),
                                  containerSoruce: PreviewPersistentContainer.shared)
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        let expectation = XCTestExpectation()
        
        //  When
        vm.$matches
            .sink { value in
                print("sink \(value)")
                expectation.fulfill()
            }
            .store(in: &cancellable)
        
        //  Then
        wait(for: [expectation], timeout: 1)
        XCTAssertFalse(vm.summoners.isEmpty)
        XCTAssertFalse(vm.matches.isEmpty)
    }

}
