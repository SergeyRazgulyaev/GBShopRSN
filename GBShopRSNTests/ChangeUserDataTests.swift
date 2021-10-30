//
//  ChangeUserDataTests.swift
//  GBShopRSNTests
//
//  Created by Sergey Razgulyaev on 20.02.2021.
//

import XCTest
import Alamofire
@testable import GBShopRSN

class ChangeUserDataTests: XCTestCase {
    
    //MARK: - Positive tests
    func testChangeUserData() throws {
        let baseURL = try XCTUnwrap(URL(string: "https://thawing-wildwood-54540.herokuapp.com/"))
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        
        let changeData = ChangeUserData(baseURL: baseURL, errorParser: ErrorParser(), sessionManager: session, queue: DispatchQueue.global(qos: .utility))
        
        let changedUserData = expectation(description: "changed user data")
        changeData.changeUserData(userID: 787, userName: "Sergey", userLastName: "Razgulyaev", password: "mypassword", email: "some@some.ru", gender: "m", creditCard: "9872389-2424-234224-234", bio: "This is good! I think I will switch to another language") {response in
            switch response.result {
            case .success(let model):
                XCTAssertEqual(model.result, 1)
                changedUserData.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 20)
    }
    
    //MARK: - Negative tests
    func testFailedChangeUserData() throws {
        let baseURL = try XCTUnwrap(URL(string: "https://wrongUrl.com"))
        
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        
        let changeData = ChangeUserData(baseURL: baseURL, errorParser: ErrorParser(), sessionManager: session, queue: DispatchQueue.global(qos: .utility))
        
        let failedChangedUserData = expectation(description: "failed change user data")
        changeData.changeUserData(userID: 787, userName: "Sergey", userLastName: "Razgulyaev", password: "mypassword", email: "some@some.ru", gender: "m", creditCard: "9872389-2424-234224-234", bio: "This is good! I think I will switch to another language") {response in
            switch response.result {
            case .success(let model):
                XCTFail("Must have failed: \(model)")
            case .failure:
                failedChangedUserData.fulfill()
            }
        }
        waitForExpectations(timeout: 20)
    }
}
