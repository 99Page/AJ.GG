//
//  RegisterViewTests.swift
//  AJ.GGUITests
//
//  Created by 노우영 on 2023/02/28.
//

import XCTest
@testable import AJ_GG

final class SummonerRegistrationViewTests: XCTestCase {
    
    var app: XCUIApplication?
    
    override func setUpWithError() throws {
        app = XCUIApplication()
        if let app = app {
            app.navigateToSummonerRegistrationView()
        }
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_SummonerRegistrationView_alert_doesExists() {
        //  Given
        guard let app = app else {
            XCTFail()
            return
        }
        
        app.launchEnvironment = ["-SummonerService" : "failure"]
        app.launch()
        
        let key = app.keys["A"]
        let key2 = app.keys["a"]
        let alert = app.alerts.firstMatch
        //  When
        
        key.tap()
        key2.tap()
        key2.tap()
        app.buttons["SearchButton"].tap()
        
        //  Then
        let alertExists = alert.waitForExistence(timeout: 2)
        XCTAssertTrue(alertExists)
    }
    
    func test_SummonerRegistrationView_alert_doesExists2() {
        //  Given
        guard let app = app else {
            XCTFail()
            return
        }
        
        app.launchEnvironment = ["-SummonerService" : "success",
                                 "-LeagueV4Service" : "success",
                                 "-MatchV5Service" : "success"]
        app.launch()
        let alert = app.alerts.firstMatch
        let searchButton = app.buttons["SearchButton"]
        
        //  When
        searchButton.tap()
        
        //  Then
        let alertExists = alert.waitForExistence(timeout: 1)
        XCTAssertTrue(alertExists)

    }
}
