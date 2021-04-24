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
        let baseURL = URL(string: "https://thawing-wildwood-54540.herokuapp.com/")!
        let requestFactory = RequestFactory(baseURL: baseURL)
        let logInUser = requestFactory.makeLogInRequestFactory()
        
        let signedIn = expectation(description: "log in")
        logInUser.logIn(userLogin: "SergeyRazgulyaev", password: "mypassword") { response in
            switch response.result {
            case .success(let model):
                XCTAssertEqual(model.user.userID, 787)
                signedIn.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 20)
    }
}
