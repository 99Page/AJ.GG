//
//  XCUIApplcation + Extensions.swift
//  AJ.GGUITests
//
//  Created by 노우영 on 2023/03/09.
//

import XCTest
@testable import AJ_GG

extension XCUIApplication {
    func navigateToSummonerRegistrationView() {
        self.launchEnvironment = ["-ContainerSource" : "empty"]
    }
}
