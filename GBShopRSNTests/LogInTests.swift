//
//  LogInTests.swift
//  GBShopRSNTests
//
//  Created by Sergey Razgulyaev on 20.02.2021.
//

import XCTest
import Alamofire
@testable import GBShopRSN

class LogInTests: XCTestCase {

    //MARK: - Positive tests
    func testLogIn() throws {
        let baseURL = try XCTUnwrap(URL(string: "https://thawing-wildwood-54540.herokuapp.com/"))
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        
        let logInUser = LogIn(baseURL: baseURL, errorParser: ErrorParser(), sessionManager: session, queue: DispatchQueue.global(qos: .utility))
        
        let loggedIn = expectation(description: "logged in")
        logInUser.logIn(userLogin: "SergeyRazgulyaev", password: "mypassword") {response in
            switch response.result {
            case .success(let model):
                XCTAssertEqual(model.result, 1)
                XCTAssertEqual(model.user.userID, 787)
                XCTAssertEqual(model.user.userLogin, "SergeyRazgulyaev")
                XCTAssertEqual(model.user.userName, "Sergey")
                XCTAssertEqual(model.user.userLastName, "Razgulyaev")
                loggedIn.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 20)
    }

    //MARK: - Negative tests
    func testFailedLogIn() throws {
        let baseURL = try XCTUnwrap(URL(string: "https://wrongUrl.com"))
        
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        
        let logInUser = LogIn(baseURL: baseURL, errorParser: ErrorParser(), sessionManager: session, queue: DispatchQueue.global(qos: .utility))
        
        let failedLogIn = expectation(description: "failed log in")
        logInUser.logIn(userLogin: "SergeyRazgulyaev", password: "mypassword") {response in
            switch response.result {
            case .success(let model):
                XCTFail("Must have failed: \(model)")
            case .failure:
                failedLogIn.fulfill()
            }
        }
        waitForExpectations(timeout: 20)
    }
}
