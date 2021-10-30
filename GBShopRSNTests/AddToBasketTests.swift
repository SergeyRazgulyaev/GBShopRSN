//
//  AddToBasketTests.swift
//  GBShopRSNTests
//
//  Created by Sergey Razgulyaev on 03.03.2021.
//

import XCTest
import Alamofire
@testable import GBShopRSN

class AddToBasketTests: XCTestCase {
    
    //MARK: - Positive tests
    func testAddToBasket() throws {
        let baseURL = try XCTUnwrap(URL(string: "https://thawing-wildwood-54540.herokuapp.com/"))        
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        
        let addToBasket = AddToBasket(baseURL: baseURL, errorParser: ErrorParser(), sessionManager: session, queue: DispatchQueue.global(qos: .utility))
        
        let addedToBasketProduct = expectation(description: "add to basket")
        addToBasket.addToBasket(addedProductID: 123, updatedQuantityInBasket: 5) {response in
            switch response.result {
            case .success(let model):
                XCTAssertEqual(model.result, 1)
                addedToBasketProduct.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 20)
    }
    
    //MARK: - Negative tests
    func testFailedAddToBasket() throws {
        let baseURL = try XCTUnwrap(URL(string: "https://wrongUrl.com"))
        
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        
        let addToBasket = AddToBasket(baseURL: baseURL, errorParser: ErrorParser(), sessionManager: session, queue: DispatchQueue.global(qos: .utility))
        
        let failedAddedToBasketProduct = expectation(description: "failed add to basket")
        addToBasket.addToBasket(addedProductID: 123, updatedQuantityInBasket: 1) {response in
            switch response.result {
            case .success(let model):
                XCTFail("Must have failed: \(model)")
            case .failure:
                failedAddedToBasketProduct.fulfill()
            }
        }
        waitForExpectations(timeout: 20)
    }
}
