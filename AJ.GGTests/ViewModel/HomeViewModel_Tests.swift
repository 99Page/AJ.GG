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
        viewModel = HomeViewModel(matchV5Serivce: MockMatchV5ServiceSuccess(),
                                  containerSoruce: PreviewPersistentContainer.shared)
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        let expectation = XCTestExpectation()
        
        //  When
        vm.$summoners
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellable)
        
        //  Then
        wait(for: [expectation], timeout: 1)
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
            .dropFirst()
            .sink { value in
                expectation.fulfill()
                print("value : \(value)")
            }
            .store(in: &cancellable)
        
        //  Then
        wait(for: [expectation], timeout: 4)
        XCTAssertFalse(vm.summoners.isEmpty)
        XCTAssertFalse(vm.matches.isEmpty)
    }
    
    func test_HomeViewModel_addMatches_shouldAddMatches() {
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
            .dropFirst()
            .sink { value in
                print("sink \(value)")
                expectation.fulfill()
            }
            .store(in: &cancellable)
        
        //  Then
        wait(for: [expectation], timeout: 4)
    }
    
    func test_HomeViewModel_selectedLane_shouldBeTop() {
        //  Given
        viewModel = HomeViewModel(matchV5Serivce: MockMatchV5ServiceSuccess(),
                                  containerSoruce: PreviewPersistentContainer.shared)
        
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        //  When
        
        //  Then
        XCTAssertEqual(vm.selectedLane, Lane.top)
    }
    
    func test_HomeViewModel_laneButtonTapped_shouldChangeSelectedLane() {
        //  Given
        let lanes = Lane.selectableLanes()
        viewModel = HomeViewModel(matchV5Serivce: MockMatchV5ServiceSuccess(),
                                  containerSoruce: PreviewPersistentContainer.shared)
        
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        for _ in 0..<100 {
            //  When
            guard let randomLane = lanes.randomElement() else {
                XCTFail()
                return
            }
            
            vm.laneButtonTapped(randomLane)
            
            //  Then
            XCTAssertEqual(vm.selectedLane, randomLane)
        }
    }
    
    func test_HomeViewModel_matchesByLane_shouldBeFilterd() {
        //  Given
        let lanes: [Lane] = [.top, .mid]
        let expectation = XCTestExpectation()
        viewModel = HomeViewModel(matchV5Serivce: MockMatchV5ServiceSuccess(),
                                  containerSoruce: PreviewPersistentContainer.shared)
        
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        vm.$matches
            .dropFirst()
            .sink { value in
                print("sink \(value)")
                expectation.fulfill()
            }
            .store(in: &cancellable)
        
        for _ in 0..<100 {
            //  When
            guard let lane = lanes.randomElement() else {
                XCTFail()
                return
            }
            
            vm.laneButtonTapped(lane)
            let count = vm.matches.filter {
                $0.isEqualLane(lane)
            }.count
            
            //  Then
            XCTAssertEqual(count, vm.matchesByLane.count)
            wait(for: [expectation], timeout: 4)
        }
    }
}
