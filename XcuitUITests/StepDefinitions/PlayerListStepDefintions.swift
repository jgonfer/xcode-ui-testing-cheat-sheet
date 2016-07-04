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
            // Tap the first row of Sylvanas
            self.app.tables.cells["Sylvanas"].tap()
        }
        
        step("The image displayed should be ([a-zA-Z]*)") { (matches: [String]) in
            // Check that we have a valid name to use
            XCTAssertNotNil(matches.first, "Invalid character name.")
            
            // Wait until the navigation animation ends and the image appears
            let expectedValue = matches.first!.lowercaseString
            let playerImage = self.app.images["\(expectedValue)-big"]
            let exists = NSPredicate(format: "exists == true")
            self.test.expectationForPredicate(exists, evaluatedWithObject: playerImage, handler: nil)
            self.test.waitForExpectationsWithTimeout(2, handler: nil)
            
            // Check if the image of Sylvanas exists with the NSPredicate 'exists'
            XCTAssert(playerImage.exists, "The character displayed doesn't match the character selected.")
        }
    }
    
}