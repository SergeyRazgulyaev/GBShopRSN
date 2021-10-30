//
//  GetProductTests.swift
//  GBShopRSNTests
//
//  Created by Sergey Razgulyaev on 21.02.2021.
//

import XCTest
import Alamofire
@testable import GBShopRSN

class GetProductTests: XCTestCase {
    
    //MARK: - Positive tests
    func testGetProduct() throws {
        let baseURL = try XCTUnwrap(URL(string: "https://thawing-wildwood-54540.herokuapp.com/"))
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        
        let getProduct = GetProduct(baseURL: baseURL, errorParser: ErrorParser(), sessionManager: session, queue: DispatchQueue.global(qos: .utility))
        
        let receivedProduct = expectation(description: "received product")
        getProduct.getProduct(productID: 123) {response in
            switch response.result {
            case .success(let model):
                XCTAssertEqual(model.result, 1)
                XCTAssertEqual(model.product.productID, 123)
                XCTAssertEqual(model.product.productName, "Notebook")
                XCTAssertEqual(model.product.productPrice, 45600)
                XCTAssertEqual(model.product.productDescription, "Powerful AMD gaming laptop with 4K resolution and long battery life")
                XCTAssertEqual(model.product.quantityInBasket, 0)
                receivedProduct.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 20)
    }
    
    //MARK: - Negative tests
    func testFailedGetProduct() throws {
        let baseURL = try XCTUnwrap(URL(string: "https://wrongUrl.com"))
        
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        
        let getProduct = GetProduct(baseURL: baseURL, errorParser: ErrorParser(), sessionManager: session, queue: DispatchQueue.global(qos: .utility))
        
        let failedReceiveProduct = expectation(description: "failed receive product")
        getProduct.getProduct(productID: 123) {response in
            switch response.result {
            case .success(let model):
                XCTFail("must have failed: \(model)")
            case .failure:
                failedReceiveProduct.fulfill()
            }
        }
        waitForExpectations(timeout: 20)
    }
}
