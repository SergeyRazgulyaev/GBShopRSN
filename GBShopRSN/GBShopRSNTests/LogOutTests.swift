//
//  LogOutTests.swift
//  GBShopRSNTests
//
//  Created by Sergey Razgulyaev on 20.02.2021.
//

import XCTest
import Alamofire
@testable import GBShopRSN

class LogOutTests: XCTestCase {

    //MARK: - Positive tests
    func testLogOutUser() throws {
        let baseURL = try XCTUnwrap(URL(string: "https://thawing-wildwood-54540.herokuapp.com/"))        
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        
        let logOutUser = LogOut(baseURL: baseURL, errorParser: ErrorParser(), sessionManager: session, queue: DispatchQueue.global(qos: .utility))
        
        let logOut = expectation(description: "log out user")
        logOutUser.logOut(userID: 787) {response in
            switch response.result {
            case .success(let model):
                XCTAssertEqual(model.result, 1)
                logOut.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 20)
    }

    //MARK: - Negative tests
    func testFailedLogOut() throws {
        let baseURL = try XCTUnwrap(URL(string: "https://wrongUrl.com"))
        
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        
        let logOutUser = LogOut(baseURL: baseURL, errorParser: ErrorParser(), sessionManager: session, queue: DispatchQueue.global(qos: .utility))
        
        let failedLogOut = expectation(description: "failed log out user")
        logOutUser.logOut(userID: 787) {response in
            switch response.result {
            case .success(let model):
                XCTFail("Must have failed: \(model)")
            case .failure:
                failedLogOut.fulfill()
            }
        }
        waitForExpectations(timeout: 20)
    }
}
