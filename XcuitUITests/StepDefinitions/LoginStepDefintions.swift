//
//  LoginStepDefintions.swift
//  Xcuit
//
//  Created by Josep Gonzalez Fernandez on 10/7/16.
//  Copyright © 2016 jgonfer. All rights reserved.
//

import XCTest
import XCTest_Gherkin

class LoginStepDefintions: StepDefiner {
    let app = XCUIApplication()
    
    override func defineSteps() {
        
        // MARK: GIVEN Steps
        
        step("An initial Login screen state") {
        }
        
        step("A logged session") {
            print(self.app.debugDescription)
            let email = self.app.textFields["login_textfield_email"]
            email.tap()
            email.typeText("demo@domain.com")
            
            let password = self.app.secureTextFields["login_textfield_password"]
            password.tap()
            password.typeText("demo")
            
            self.app.buttons["login_login"].tap()
        }
        
        // MARK: WHEN Steps
        
        step("I tap the ([a-zA-Z]*) button") { (matches: [String]) in
            XCTAssert(matches.count >= 1, "Button not found.")
            
            var button = ""
            for param: String in matches {
                if button.isEmpty {
                    button = param.lowercaseString
                }
            }
            self.app.buttons["login_\(button)"].tap()
        }
        
        step("I type an invalid ([a-zA-Z]*)") { (matches: [String]) in
            XCTAssert(matches.count >= 1, "Textfield not found.")
            
            var object = ""
            for param: String in matches {
                if object.isEmpty {
                    object = param.lowercaseString
                }
            }
            let textfield = self.app.textFields["login_textfield_\(object)"]
            textfield.tap()
            switch object {
            case "email":
                textfield.typeText("invalid")
            default:
                break
            }
        }
        
        step("I type a valid ([a-zA-Z]*)") { (matches: [String]) in
            XCTAssert(matches.count >= 1, "Textfield not found.")
            
            var object = ""
            for param: String in matches {
                if object.isEmpty {
                    object = param.lowercaseString
                }
            }
            switch object {
            case "email":
                let textfield = self.app.textFields["login_textfield_\(object)"]
                textfield.tap()
                textfield.typeText("a@a.aa")
            case "password":
                let secureTextfield = self.app.secureTextFields["login_textfield_\(object)"]
                secureTextfield.tap()
                secureTextfield.typeText("aaa")
            default:
                break
            }
        }
        
        
        // MARK: THEN Steps
        
        step("An error alert appears for the ([a-zA-Z]*) view") { (matches: [String]) in
            XCTAssert(matches.count >= 1, "Invalid number of parameters.")
            
            var view = ""
            for param: String in matches {
                if view.isEmpty {
                    view = param.lowercaseString
                }
            }
            let alertImage = self.app.images["login_alert_\(view)"]
            let hittable = NSPredicate(format: "hittable == true")
            self.test.expectationForPredicate(hittable, evaluatedWithObject: alertImage, handler: nil)
            self.test.waitForExpectationsWithTimeout(2, handler: nil)
            
            XCTAssert(alertImage.hittable, "The alert image didn't appear, so there isn't an error.")
        }
        
        step("The Catalogue screen is displayed") {
            let nav = self.app.navigationBars["ESCAPARATE"]
            let exists = NSPredicate(format: "exists == true")
            self.test.expectationForPredicate(exists, evaluatedWithObject: nav, handler: nil)
            self.test.waitForExpectationsWithTimeout(5, handler: nil)
            
            XCTAssert(nav.hittable, "The Catalogue screen isn't visible.")
        }
    }
    
}