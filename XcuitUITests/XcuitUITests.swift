//
//  XcuitUITests.swift
//  XcuitUITests
//
//  Created by jgonzalez on 28/6/16.
//  Copyright © 2016 jgonfer. All rights reserved.
//

import XCTest

class XcuitUITests: XCTestCase {
    let app = XCUIApplication()
        
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        app.launch()
    }
    
    func test01ShowVisiblePlayerFromList() {
        // Tap the first row of Sylvanas
        app.tables.cells["Sylvanas"].tap()
        
        // Wait until the navigation animation ends
        let player = app.images["sylvanas-big"]
        let exists = NSPredicate(format: "exists == true")
        expectationForPredicate(exists, evaluatedWithObject: player, handler: nil)
        waitForExpectationsWithTimeout(2, handler: nil)
        
        // Check if the image of Sylvanas exists with the NSPredicate 'exists'
        XCTAssert(player.exists, "The Player displayed doesn't match the Player selected.")
        
        // Tap the back button
        app.navigationBars.buttons["Players"].tap()
        
    }
    
    func test02ShowHiddenPlayerFromList() {
        // Tap the last row of Artanis, which isn't visible
        app.tables.cells["Artanis"].tap()
        
        let player = app.images["artanis-big"]
        let exists = NSPredicate(format: "exists == true")
        expectationForPredicate(exists, evaluatedWithObject: player, handler: nil)
        waitForExpectationsWithTimeout(2, handler: nil)
        
        XCTAssert(app.images["artanis-big"].exists, "The Player displayed doesn't match the Player selected.")
        
        app.navigationBars.buttons["Players"].tap()
    }
}
