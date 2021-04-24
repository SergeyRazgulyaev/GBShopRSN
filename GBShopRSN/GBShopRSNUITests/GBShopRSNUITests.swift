//
//  GBShopRSNUITests.swift
//  GBShopRSNUITests
//
//  Created by Sergey Razgulyaev on 14.02.2021.
//

import XCTest

class GBShopRSNUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
      
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
        
        let logInButton = app.buttons["showLogInScreenButton"].firstMatch
        XCTAssertTrue(logInButton.isHittable, "\(app.debugDescription)")
        logInButton.tap()
        
        let logInScreenView = app.otherElements["logInScreenView"].firstMatch
        XCTAssertTrue(logInScreenView.waitForExistence(timeout: 1))
        
        let userNameTextField = logInScreenView.textFields["userLoginTextField"]
        userNameTextField.tap()
        userNameTextField.typeText("SergeyRazgulyaev")
        
        let passwordTextField = logInScreenView.textFields["passwordTextField"]
        passwordTextField.tap()
        passwordTextField.typeText("mypassword")
        
        let scrollView = logInScreenView.scrollViews["logInScrollView"]
        scrollView.swipeUp()
            
        let sendDataForLogInButton = logInScreenView.buttons["sendDataForLogInButton"]
        sendDataForLogInButton.tap()
        
        let productListScreenView = app.otherElements["productListScreenView"].firstMatch
        XCTAssertTrue(productListScreenView.waitForExistence(timeout: 10))

    }
}
