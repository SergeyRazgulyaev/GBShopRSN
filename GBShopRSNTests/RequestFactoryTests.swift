//
//  RequestFactoryTests.swift
//  GBShopRSNTests
//
//  Created by Sergey Razgulyaev on 20.02.2021.
//

import XCTest
import Alamofire
@testable import GBShopRSN

class RequestFactoryTests: XCTestCase {
    
    func testLogIn() throws {
        let requestFactory = RequestFactory()
        let logInUser = requestFactory.makeLogInRequestFatory()
        
        let signedIn = expectation(description: "log in")
        logInUser.logIn(userName: "Somebody", password: "mypassword") { response in
            switch response.result {
            case .success(let model):
                XCTAssertEqual(model.user.id, 123)
                signedIn.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10)
    }
}
