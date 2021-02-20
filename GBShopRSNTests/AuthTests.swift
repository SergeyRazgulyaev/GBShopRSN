//
//  AuthTests.swift
//  GBShopRSNTests
//
//  Created by Sergey Razgulyaev on 20.02.2021.
//

import XCTest
import Alamofire
@testable import GBShopRSN

class AuthTests: XCTestCase {

    //MARK: - Positive tests
    func testLogIn() throws {
        let baseURL = try XCTUnwrap(URL(string: "https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/"))
        
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        
        let authUser = Auth(baseUrl: baseURL, errorParser: ErrorParser(), sessionManager: session, queue: DispatchQueue.global(qos: .utility))
        
        let loggedIn = expectation(description: "logged in")
        authUser.login(userName: "Somebody", password: "myPassword") {response in
            switch response.result {
            case .success(let model):
                XCTAssertEqual(model.result, 1)
                XCTAssertEqual(model.user.id, 123)
                XCTAssertEqual(model.user.login, "geekbrains")
                XCTAssertEqual(model.user.name, "John")
                XCTAssertEqual(model.user.lastname, "Doe")
                loggedIn.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10)
    }

    //MARK: - Negative tests
    func testFailedLogIn() throws {
        let baseURL = try XCTUnwrap(URL(string: "https://wrongUrl.com"))
        
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        
        let authUser = Auth(baseUrl: baseURL, errorParser: ErrorParser(), sessionManager: session, queue: DispatchQueue.global(qos: .utility))
        
        let failedLogIn = expectation(description: "failed log in")
        authUser.login(userName: "Somebody", password: "myPassword") {response in
            switch response.result {
            case .success(let model):
                XCTFail("Must have failed: \(model)")
            case .failure:
                failedLogIn.fulfill()
            }
        }
        waitForExpectations(timeout: 10)
    }
}
