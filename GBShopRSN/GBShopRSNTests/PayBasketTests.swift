//
//  PayBasketTests.swift
//  GBShopRSNTests
//
//  Created by Sergey Razgulyaev on 03.03.2021.
//

import XCTest
import Alamofire
@testable import GBShopRSN

class PayBasketTests: XCTestCase {
    
    //MARK: - Positive tests
    func testPayBasket() throws {
        let baseURL = try XCTUnwrap(URL(string: "https://thawing-wildwood-54540.herokuapp.com/"))
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        
        let payBasket = PayBasket(baseURL: baseURL, errorParser: ErrorParser(), sessionManager: session, queue: DispatchQueue.global(qos: .utility))
        
        let payBasketProducts = expectation(description: "pay basket")
        payBasket.payBasket(userID: 787, payAmount: 1000) {response in
            switch response.result {
            case .success(let model):
                XCTAssertEqual(model.result, 1)
                XCTAssertEqual(model.accountBalance, 999000)
                payBasketProducts.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 20)
    }
    
    //MARK: - Negative tests
    func testFailedPayBasket() throws {
        let baseURL = try XCTUnwrap(URL(string: "https://wrongUrl.com"))
        
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        
        let payBasket = PayBasket(baseURL: baseURL, errorParser: ErrorParser(), sessionManager: session, queue: DispatchQueue.global(qos: .utility))
        
        let failedPayBasketProduct = expectation(description: "failed pay basket")
        payBasket.payBasket(userID: 787, payAmount: 1000) {response in
            switch response.result {
            case .success(let model):
                XCTFail("Must have failed: \(model)")
            case .failure:
                failedPayBasketProduct.fulfill()
            }
        }
        waitForExpectations(timeout: 20)
    }
}
