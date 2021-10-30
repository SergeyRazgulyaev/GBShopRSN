//
//  GetReviewsTests.swift
//  GBShopRSNTests
//
//  Created by Sergey Razgulyaev on 26.02.2021.
//

import XCTest
import Alamofire
@testable import GBShopRSN

class GetReviewsTests: XCTestCase {
    
    //MARK: - Positive tests
    func testGetReviews() throws {
        let baseURL = try XCTUnwrap(URL(string: "https://thawing-wildwood-54540.herokuapp.com/"))        
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        
        let getReviews = GetReviews(baseURL: baseURL, errorParser: ErrorParser(), sessionManager: session, queue: DispatchQueue.global(qos: .utility))
        
        let receivedReviews = expectation(description: "received reviews")
        getReviews.getReviews(pageNumber: 1, productID: 123) {response in
            switch response.result {
            case .success(let model):
                XCTAssertEqual(model.pageNumber, 1)
                XCTAssertEqual(model.reviews[0].commentID, 2)
                XCTAssertEqual(model.reviews[0].productID, 123)
                XCTAssertEqual(model.reviews[0].userID, 352)
                XCTAssertEqual(model.reviews[0].userName, "Max")
                XCTAssertEqual(model.reviews[0].userLastName, "Greedy")
                XCTAssertEqual(model.reviews[0].text, "I liked the look and functionality of the laptop. The computer is just super, I play at home and in the park in the fresh air.")
                XCTAssertEqual(model.reviews[1].commentID, 1)
                XCTAssertEqual(model.reviews[1].productID, 123)
                XCTAssertEqual(model.reviews[1].userID, 946)
                XCTAssertEqual(model.reviews[1].userName, "Nik")
                XCTAssertEqual(model.reviews[1].userLastName, "Johnson")
                XCTAssertEqual(model.reviews[1].text, "This is a cool product! My grandfather is shocked!")
                receivedReviews.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 20)
    }
    
    //MARK: - Negative tests
    func testFailedGetReviews() throws {
        let baseURL = try XCTUnwrap(URL(string: "https://wrongUrl.com"))
        
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        
        let getReviews = GetReviews(baseURL: baseURL, errorParser: ErrorParser(), sessionManager: session, queue: DispatchQueue.global(qos: .utility))
        
        let failedReceiveReviews = expectation(description: "failed receive reviews")
        getReviews.getReviews(pageNumber: 1, productID: 123) {response in
            switch response.result {
            case .success(let model):
                XCTFail("must have failed: \(model)")
            case .failure:
                failedReceiveReviews.fulfill()
            }
        }
        waitForExpectations(timeout: 20)
    }
}
