//
//  PlayerListStepDefintions.swift
//  Xcuit
//
//  Created by jgonzalez on 1/7/16.
//  Copyright © 2016 jgonfer. All rights reserved.
//

import XCTest
import XCTest_Gherkin

class PlayerListStepDefintions: StepDefiner {
    let app = XCUIApplication()
    
    override func defineSteps() {
        step("A first run state") {
            print("Hola")
        }
        
        step("I tap the Sylvanas row") {
            self.app.tables.cells["Sylvanas"].tap()
        }
        
        /*
        step("This value should be ([0-9]*)") { (matches: [String]) in
            let expectedValue = matches.first!
            let someValueFromTheUI = /* However you want to get this */
                XCTAssertEqual(expectedValue, someValueFromTheUI)
        }
        */
    }
    
}
