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

    func test_SummonerRegistrationView_networkErrorAlert_doesExists() {
        //  Given
        guard let app = app else {
            XCTFail()
            return
        }
        app.launch()
        app.launchEnvironment = ["-SummonerService" : "Failure"]
        
        let key = app.keys["A"]
        let key2 = app.keys["a"]
        let alert = app.alerts.firstMatch
        //  When
        
        key.tap()
        key2.tap()
        key2.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Search"]/*[[".keyboards",".buttons[\"검색\"]",".buttons[\"Search\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        //  Then
        let alertExists = alert.waitForExistence(timeout: 2)
        XCTAssertTrue(alertExists)
    }
}
