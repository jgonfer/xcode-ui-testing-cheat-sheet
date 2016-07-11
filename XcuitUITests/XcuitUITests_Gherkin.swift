//
//  XcuitUITests_Gherkin.swift
//  Xcuit
//
//  Created by jgonzalez on 1/7/16.
//  Copyright © 2016 jgonfer. All rights reserved.
//

import XCTest
import XCTest_Gherkin

class XcuitUITests_Gherkin: XCTestCase {
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        app.launch()
        
        /*
         * Wait 1 second until the UI is ready.
         * Sometimes you can see some events at
         * the beginning that won't be handled.
         */
        sleep(1)
    }
    
    override func tearDown() {
        super.tearDown()
        
        let backButton = app.navigationBars.buttons["Back"]
        if backButton.hittable {
            backButton.tap()
        }
        
        let tabBarPlayersButton = app.tabBars.buttons["Players"]
        if tabBarPlayersButton.hittable {
            tabBarPlayersButton.tap()
        }
        
        let logoutButton = app.buttons["Stop"]
        if logoutButton.hittable {
            logoutButton.tap()
        }
    }
    
    func test01ShowVisiblePlayerFromList() {
        Given("A logged session")
        When("I tap the Sylvanas row")
        Then("The image displayed should be Sylvanas")
    }
    
    func test02ShowHiddenPlayerFromList() {
        Given("A logged session")
        When("I tap the Artanis row")
        Then("The image displayed should be Artanis")
    }
}
