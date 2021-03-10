//
//  DeleteReviewTests.swift
//  GBShopRSNTests
//
//  Created by Sergey Razgulyaev on 26.02.2021.
//

import XCTest
import Alamofire
@testable import GBShopRSN

class DeleteReviewTests: XCTestCase {
    
    //MARK: - Positive tests
    func testDeleteReview() throws {
//        let baseURL = try XCTUnwrap(URL(string: "http://127.0.0.1:8080"))
        let baseURL = try XCTUnwrap(URL(string: "https://thawing-wildwood-54540.herokuapp.com/"))
        
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        
        let deleteReview = DeleteReview(baseUrl: baseURL, errorParser: ErrorParser(), sessionManager: session, queue: DispatchQueue.global(qos: .utility))
        
        let deletedReview = expectation(description: "deleted review")
        deleteReview.deleteReview(idComment: 123) {response in
            switch response.result {
            case .success(let model):
                XCTAssertEqual(model.result, 1)
                deletedReview.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10)
    }
    
    //MARK: - Negative tests
    func testFailedDeleteReview() throws {
        let baseURL = try XCTUnwrap(URL(string: "https://wrongUrl.com"))
        
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        
        let deleteReview = DeleteReview(baseUrl: baseURL, errorParser: ErrorParser(), sessionManager: session, queue: DispatchQueue.global(qos: .utility))
        
        let failedDeleteReview = expectation(description: "failed delete review")
        deleteReview.deleteReview(idComment: 123) {response in
            switch response.result {
            case .success(let model):
                XCTFail("Must have failed: \(model)")
            case .failure:
                failedDeleteReview.fulfill()
            }
        }
        waitForExpectations(timeout: 10)
    }
}
