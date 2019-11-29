//
//  BilligeBamser1_0UITests.swift
//  BilligeBamser1.0UITests
//
//  Created by Nicolai Dam on 29/11/2019.
//  Copyright © 2019 Jacob Jørgensen. All rights reserved.
//

import XCTest

class BilligeBamser1_0UITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    // hver opmærksom på at for at denne test kan køres korrekt, skal man ved textField(kode) i storyboard fjerne fluebenet ved "Secure Text Entry".
    func testEnabledLoginButton() {
        // UI tests must launch the application that they test.
        
        let invalidMail = "1234"
        let invalidKode = "123456"
        
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["JEG HAR ALLEREDE EN BRUGER"].tap()
        
        XCTAssertFalse(app.buttons["Login"].isEnabled)
        
        let mailTextField = app.textFields["Indtast din email"]
        mailTextField.tap()
        mailTextField.typeText(invalidMail)
        
        let kodeTextField = app.textFields["Indtast dit password"]
        kodeTextField.tap()
        kodeTextField.typeText(invalidKode)

        XCTAssertTrue(app.buttons["Login"].isEnabled)
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    // Tester at der kommer en alert ved opretBruger når mailen ikke er korrekt
    func testMailAlertInOpretBruger() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["OPRET BRUGER MED EMAIL"].tap()
        
        XCTAssertFalse(app.alerts.element.exists)
        
        let navnTextField = app.textFields["Indtast dit navn"]
        // mailTextField.tap()
        navnTextField.typeText("TEST HANSEN")
        
        let mailTextField = app.textFields["Indtast din email"]
        mailTextField.tap()
        mailTextField.typeText("ffjfj.dk")
        
        let kodeTextField = app.textFields["Indtast dit password"]
        kodeTextField.tap()
        kodeTextField.typeText("123456")
        
        app.buttons["Opret"].tap()
        
        XCTAssertTrue(app.alerts.element.exists)
        
        
        
    }
    

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
