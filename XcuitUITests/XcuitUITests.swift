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
        
        /* 
         * Wait 1 second until the UI is ready.
         * Sometimes you can see some events at
         * the beginning that won't be handled.
         */
        sleep(1)
    }
    
    func test01ShowVisiblePlayerFromList() {
        let player = "Sylvanas"
        // Tap the first row of Sylvanas
        app.tables.cells[player].tap()
        
        // Wait until the navigation animation ends and the image appears
        let playerImage = app.images["\(player.lowercaseString)-big"]
        let exists = NSPredicate(format: "exists == true")
        expectationForPredicate(exists, evaluatedWithObject: playerImage, handler: nil)
        waitForExpectationsWithTimeout(2, handler: nil)
        
        // Check if the image of Sylvanas exists with the NSPredicate 'exists'
        XCTAssert(playerImage.exists, "The Player displayed doesn't match the Player selected.")
        
        // Tap the back button
        app.navigationBars.buttons["Players"].tap()
        
    }
    
    func test02ShowHiddenPlayerFromList() {
        let player = "Artanis"
        // Tap the last row of Artanis, which isn't visible
        app.tables.cells[player].tap()
        
        // Wait until the navigation animation ends and the image appears
        let playerImage = app.images["\(player.lowercaseString)-big"]
        let exists = NSPredicate(format: "exists == true")
        expectationForPredicate(exists, evaluatedWithObject: playerImage, handler: nil)
        waitForExpectationsWithTimeout(2, handler: nil)
        
        // Check if the image of Artanis exists with the NSPredicate 'exists'
        XCTAssert(playerImage.exists, "The Player displayed doesn't match the Player selected.")
        
        // Tap the back button
        app.navigationBars.buttons["Players"].tap()
    }
    
    func test03PurchaseANonOwnedCharacter() {
        let player = "Sylvanas"
        // Get the Sylvanas row
        let cell = app.tables.cells[player]
        // Check that we don't own the character yet
        XCTAssert(cell.images["\(player.lowercaseString)-owned-no"].exists, "You already own this character.")
        // Tap the Sylvanas row
        cell.tap()
        
        // Wait until the purchase button is added to the view and exists
        let purchaseButton = app.buttons["purchase-button"]
        waitForExists(purchaseButton, waitSeconds: 2)
        
        // Wait fot button animation ends (its duration is 1 second)
        sleep(1)
        
        // Tap the purchase button
        purchaseButton.tap()
        
        // Check that we've purchased Sylvanas character
        XCTAssert(cell.images["sylvanas-owned"].exists, "You didn't purchase this character.")
    }
    
    func test04PurchaseAnOwnedCharacter() {
        let player = "Sylvanas"
        // Get the Sylvanas row
        let cell = app.tables.cells[player]
        // We do the same that we did in test03 for the purpose
        // of try to buy the same Sylvanas character
        test03PurchaseANonOwnedCharacter()
        // Tap the Sylvanas row
        cell.tap()
        
        // Check that isn't possible to buy again the same Sylvanas character
        // and a message label appears instead of the purchase button
        let messageLabel = app.staticTexts["message-label"]
        waitForExists(messageLabel, waitSeconds: 2)
    }
    
    func test05PullToOrderPlayersList() {
        let playerDisordered = "Sylvanas"
        let playerOrdered = "Artanis"
        // Get first row
        let firstCell = app.tables["players"].cells.elementBoundByIndex(0)
        // Check that the first row is Sylvanas
        XCTAssert(firstCell.identifier == playerDisordered)
        let start = firstCell.coordinateWithNormalizedOffset(CGVectorMake(0, 0))
        let finish = firstCell.coordinateWithNormalizedOffset(CGVectorMake(0, 5))
        // Pull from start point to end point
        start.pressForDuration(0, thenDragToCoordinate: finish)
        // Check that the first row has changed and now is Artanis
        XCTAssert(firstCell.identifier == playerOrdered)
    }
}

extension XCTestCase {
    func waitForHittable(element: XCUIElement, waitSeconds: Double, file: String = #file, line: UInt = #line) {
        let existsPredicate = NSPredicate(format: "hittable == true")
        expectationForPredicate(existsPredicate, evaluatedWithObject: element, handler: nil)
        
        waitForExpectationsWithTimeout(waitSeconds) { (error) -> Void in
            if (error != nil) {
                let message = "Failed to find \(element) after \(waitSeconds) seconds."
                self.recordFailureWithDescription(message,
                                                  inFile: file, atLine: line, expected: true)
            }
        }
    }
    
    func waitForNotHittable(element: XCUIElement, waitSeconds: Double, file: String = #file, line: UInt = #line) {
        let existsPredicate = NSPredicate(format: "hittable == false")
        expectationForPredicate(existsPredicate, evaluatedWithObject: element, handler: nil)
        
        waitForExpectationsWithTimeout(waitSeconds) { (error) -> Void in
            if (error != nil) {
                let message = "Failed to find \(element) after \(waitSeconds) seconds."
                self.recordFailureWithDescription(message,
                                                  inFile: file, atLine: line, expected: true)
            }
        }
    }
    
    func waitForExists(element: XCUIElement, waitSeconds: Double, file: String = #file, line: UInt = #line) {
        let existsPredicate = NSPredicate(format: "exists == true")
        expectationForPredicate(existsPredicate, evaluatedWithObject: element, handler: nil)
        
        waitForExpectationsWithTimeout(waitSeconds) { (error) -> Void in
            if (error != nil) {
                let message = "Failed to find \(element) after \(waitSeconds) seconds."
                self.recordFailureWithDescription(message,
                                                  inFile: file, atLine: line, expected: true)
            }
        }
    }
    
}

