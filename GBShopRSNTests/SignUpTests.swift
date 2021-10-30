//
//  SignUpTests.swift
//  GBShopRSNTests
//
//  Created by Sergey Razgulyaev on 20.02.2021.
//

import XCTest
import Alamofire
@testable import GBShopRSN

class SignUpTests: XCTestCase {
    
    //MARK: - Positive tests
    func testSignUp() throws {
        let baseURL = try XCTUnwrap(URL(string: "https://thawing-wildwood-54540.herokuapp.com/"))
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        
        let registerUser = SignUp(baseURL: baseURL, errorParser: ErrorParser(), sessionManager: session, queue: DispatchQueue.global(qos: .utility))
        
        let registered = expectation(description: "registered user")
        registerUser.signUp(userID: 787, userLogin: "SergeyRazgulyaev", userName: "Sergey", userLastName: "Razgulyaev", password: "mypassword", email: "razgulyaev.sergey@gmail.com", gender: "m", creditCard: "9872389-2424-234224-234", bio: "This is good! I think I will switch to another language") {response in
            switch response.result {
            case .success(let model):
                XCTAssertEqual(model.result, 1)
                XCTAssertEqual(model.userMessage, "Registration completed successfully!")
                registered.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 20)
    }
    
    //MARK: - Negative tests
    func testFailedSignUp() throws {
        let baseURL = try XCTUnwrap(URL(string: "https://wrongUrl.com"))
        
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        
        let registerUser = SignUp(baseURL: baseURL, errorParser: ErrorParser(), sessionManager: session, queue: DispatchQueue.global(qos: .utility))
        
        let failedRegister = expectation(description: "failed register user")
        registerUser.signUp(userID: 787, userLogin: "SergeyRazgulyaev", userName: "Sergey", userLastName: "Razgulyaev", password: "mypassword", email: "razgulyaev.sergey@gmail.com", gender: "m", creditCard: "9872389-2424-234224-234", bio: "This is good! I think I will switch to another language") {response in
            switch response.result {
            case .success(let model):
                XCTFail("Must have failed: \(model)")
            case .failure:
                failedRegister.fulfill()
            }
        }
        waitForExpectations(timeout: 20)
    }
}
