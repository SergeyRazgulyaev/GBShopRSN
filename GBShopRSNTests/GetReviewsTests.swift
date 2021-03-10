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
        
        let getReviews = GetReviews(baseUrl: baseURL, errorParser: ErrorParser(), sessionManager: session, queue: DispatchQueue.global(qos: .utility))
        
        let receivedReviews = expectation(description: "received reviews")
        getReviews.getReviews(pageNumber: 1, idProduct: 123) {response in
            switch response.result {
            case .success(let model):
                XCTAssertEqual(model.pageNumber, 1)
                XCTAssertEqual(model.reviews[0].idComment, 567)
                XCTAssertEqual(model.reviews[0].idUser, 123)
                XCTAssertEqual(model.reviews[0].text, "I liked the look and functionality of the product")
                XCTAssertEqual(model.reviews[1].idComment, 890)
                XCTAssertEqual(model.reviews[1].idUser, 456)
                XCTAssertEqual(model.reviews[1].text, "This is a good product!")
                receivedReviews.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10)
    }
    
    //MARK: - Negative tests
    func testFailedGetReviews() throws {
        let baseURL = try XCTUnwrap(URL(string: "https://wrongUrl.com"))
        
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        
        let getReviews = GetReviews(baseUrl: baseURL, errorParser: ErrorParser(), sessionManager: session, queue: DispatchQueue.global(qos: .utility))
        
        let failedReceiveReviews = expectation(description: "failed receive reviews")
        getReviews.getReviews(pageNumber: 1, idProduct: 123) {response in
            switch response.result {
            case .success(let model):
                XCTFail("must have failed: \(model)")
            case .failure:
                failedReceiveReviews.fulfill()
            }
        }
        waitForExpectations(timeout: 10)
    }
}
