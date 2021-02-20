//
//  ExitTests.swift
//  GBShopRSNTests
//
//  Created by Sergey Razgulyaev on 20.02.2021.
//

import XCTest
import Alamofire
@testable import GBShopRSN

class ExitTests: XCTestCase {

    //MARK: - Positive tests
    func testExitUser() throws {
        let baseURL = try XCTUnwrap(URL(string: "https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/"))
        
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        
        let exitUser = ExitUser(baseUrl: baseURL, errorParser: ErrorParser(), sessionManager: session, queue: DispatchQueue.global(qos: .utility))
        
        let exit = expectation(description: "exit user")
        exitUser.logout(idUser: 123) {response in
            switch response.result {
            case .success(let model):
                XCTAssertEqual(model.result, 1)
                exit.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10)
    }

    //MARK: - Negative tests
    func testFailedExitUser() throws {
        let baseURL = try XCTUnwrap(URL(string: "https://wrongUrl.com"))
        
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        
        let exitUser = ExitUser(baseUrl: baseURL, errorParser: ErrorParser(), sessionManager: session, queue: DispatchQueue.global(qos: .utility))
        
        let failedExit = expectation(description: "failed exit user")
        exitUser.logout(idUser: 123) {response in
            switch response.result {
            case .success(let model):
                XCTFail("Must have failed: \(model)")
            case .failure:
                failedExit.fulfill()
            }
        }
        waitForExpectations(timeout: 10)
    }
}
