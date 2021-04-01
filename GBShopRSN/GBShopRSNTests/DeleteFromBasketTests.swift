//
//  DeleteFromBasketTests.swift
//  GBShopRSNTests
//
//  Created by Sergey Razgulyaev on 03.03.2021.
//

import XCTest
import Alamofire
@testable import GBShopRSN

class DeleteFromBasketTests: XCTestCase {
    
    //MARK: - Positive tests
    func testDeleteFromBasket() throws {
        let baseURL = try XCTUnwrap(URL(string: "https://thawing-wildwood-54540.herokuapp.com/"))        
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        
        let deleteFromBasket = DeleteFromBasket(baseURL: baseURL, errorParser: ErrorParser(), sessionManager: session, queue: DispatchQueue.global(qos: .utility))
        
        let deletedFromBasketProduct = expectation(description: "delete from basket")
        deleteFromBasket.deleteFromBasket(deletedProductID: 123) {response in
            switch response.result {
            case .success(let model):
                XCTAssertEqual(model.result, 1)
                deletedFromBasketProduct.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 20)
    }
    
    //MARK: - Negative tests
    func testFailedDeleteFromBasket() throws {
        let baseURL = try XCTUnwrap(URL(string: "https://wrongUrl.com"))
        
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        
        let deleteFromBasket = DeleteFromBasket(baseURL: baseURL, errorParser: ErrorParser(), sessionManager: session, queue: DispatchQueue.global(qos: .utility))
        
        let failedDeletedFromBasketProduct = expectation(description: "failed delete from basket")
        deleteFromBasket.deleteFromBasket(deletedProductID: 123) {response in
            switch response.result {
            case .success(let model):
                XCTFail("Must have failed: \(model)")
            case .failure:
                failedDeletedFromBasketProduct.fulfill()
            }
        }
        waitForExpectations(timeout: 20)
    }
}
