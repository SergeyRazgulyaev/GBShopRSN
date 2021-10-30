//
//  AddReviewTests.swift
//  GBShopRSNTests
//
//  Created by Sergey Razgulyaev on 26.02.2021.
//

import XCTest
import Alamofire
@testable import GBShopRSN

class AddReviewTests: XCTestCase {
    
    //MARK: - Positive tests
    func testAddReview() throws {
        let baseURL = try XCTUnwrap(URL(string: "https://thawing-wildwood-54540.herokuapp.com/"))
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        
        let addReview = AddReview(baseURL: baseURL, errorParser: ErrorParser(), sessionManager: session, queue: DispatchQueue.global(qos: .utility))
        
        let addedReview = expectation(description: "added review")
        addReview.addReview(productID: 123,
                            userID: 787,
                            userName: "Sergey",
                            userLastName: "Razgulyaev",
                            text: "Review text") {response in
            switch response.result {
            case .success(let model):
                XCTAssertEqual(model.result, 1)
                XCTAssertEqual(model.userMessage, "Your review has been submitted for moderation")
                addedReview.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 20)
    }
    
    //MARK: - Negative tests
    func testFailedAddReview() throws {
        let baseURL = try XCTUnwrap(URL(string: "https://wrongUrl.com"))
        
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        
        let addReview = AddReview(baseURL: baseURL, errorParser: ErrorParser(), sessionManager: session, queue: DispatchQueue.global(qos: .utility))
        
        let failedAddReview = expectation(description: "failed add review")
        addReview.addReview(productID: 123,
                            userID: 787,
                            userName: "Sergey",
                            userLastName: "Razgulyaev",
                            text: "Review text") {response in
            switch response.result {
            case .success(let model):
                XCTFail("Must have failed: \(model)")
            case .failure:
                failedAddReview.fulfill()
            }
        }
        waitForExpectations(timeout: 20)
    }
}
