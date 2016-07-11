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
        let player = "Sylvanas"
        
        login()
        
        // Tap the first row of Sylvanas
        app.tables.cells[player].tap()
        
        // Wait until the navigation animation ends and the image appears
        let playerImage = app.images["\(player.lowercaseString)-big"]
        let exists = NSPredicate(format: "exists == true")
        expectationForPredicate(exists, evaluatedWithObject: playerImage, handler: nil)
        waitForExpectationsWithTimeout(2, handler: nil)
        
        // Check if the image of Sylvanas exists with the NSPredicate 'exists'
        XCTAssert(playerImage.exists, "The Player displayed doesn't match the Player selected.")
    }
    
    func test02ShowHiddenPlayerFromList() {
        let player = "Artanis"
        
        login()
        
        // Tap the last row of Artanis, which isn't visible
        app.tables.cells[player].tap()
        
        // Wait until the navigation animation ends and the image appears
        let playerImage = app.images["\(player.lowercaseString)-big"]
        let exists = NSPredicate(format: "exists == true")
        expectationForPredicate(exists, evaluatedWithObject: playerImage, handler: nil)
        waitForExpectationsWithTimeout(2, handler: nil)
        
        // Check if the image of Artanis exists with the NSPredicate 'exists'
        XCTAssert(playerImage.exists, "The Player displayed doesn't match the Player selected.")
    }
    
    func test03PurchaseANonOwnedCharacter() {
        let player = "Sylvanas"
        
        login()
        
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
        let ownedImage = cell.images["sylvanas-owned"]
        waitForExists(ownedImage, waitSeconds: 2)
        XCTAssert(ownedImage.exists, "You didn't purchase this character.")
    }
    
    func test04PurchaseAnOwnedCharacter() {
        let player = "Sylvanas"
        
        login()
        
        // We do the same that we did in test03 for the purpose
        // of try to buy the same Sylvanas character
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
        let ownedImage = cell.images["sylvanas-owned"]
        waitForExists(ownedImage, waitSeconds: 2)
        XCTAssert(ownedImage.exists, "You didn't purchase this character.")
        // --- End of test03
        
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
        
        login()
        
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
    
    func login() {
        let email = self.app.textFields["login_textfield_email"]
        email.tap()
        email.typeText("demo@domain.com")
        
        let password = self.app.secureTextFields["login_textfield_password"]
        password.tap()
        password.typeText("demo")
        
        self.app.buttons["login_login"].tap()
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

