//
//  HomeVIewModel_Tests.swift
//  AJ.GGUITests
//
//  Created by 노우영 on 2023/03/05.
//

import XCTest
@testable import AJ_GG

final class HomeViewModel_UITests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_HomeViewModel_RegisterSummonerViewNavigationLink_shouldNavigateToRegisterSummonerView() {
        //  Given
        let app = XCUIApplication()
        app.launchEnvironment = ["-ContainerSource" : "empty"]
        
        let summonerRegistrationView = app.scrollViews["SummonerRegistrationView"]
        let homeView = app.scrollViews["HomeView"]
        app.launch()
        
        //  When
        
        let registerSummonerViewExists = summonerRegistrationView.waitForExistence(timeout: 2)
        
        //  Then
        XCTAssertTrue(registerSummonerViewExists)
        XCTAssertFalse(homeView.exists)
    }
    
    
    func test_HomeViewModel_RegisterViewNavigationLink_shouldNotNavigateToRegisterSummonerView() {
        //  Given
        let app = XCUIApplication()
        app.launchEnvironment = ["-ContainerSource" : "preview"]
        app.launch()
        
        let registerSummonerView = app.scrollViews["RegisterSummonerView"]
        let homeView = app.scrollViews["HomeView"]
    
        //  When
        let registerSummonerViewExists = registerSummonerView.waitForExistence(timeout: 2)
        
        //  Then
        XCTAssertFalse(registerSummonerViewExists)
        XCTAssertTrue(homeView.exists)
    }
}
