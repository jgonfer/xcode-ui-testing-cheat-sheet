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
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
        app.terminate()
    }
    
    
    
    func testSelectSecondTab() {
        app.tabBars.buttons["Second"].tap()
    }
}
