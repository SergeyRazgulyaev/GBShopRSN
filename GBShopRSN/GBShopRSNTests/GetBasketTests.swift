//
//  GetBasketTests.swift
//  GBShopRSNTests
//
//  Created by Sergey Razgulyaev on 03.03.2021.
//

import XCTest
import Alamofire
@testable import GBShopRSN

class GetBasketTests: XCTestCase {
    
    //MARK: - Positive tests
    func testGetBasket() throws {
        let baseURL = try XCTUnwrap(URL(string: "https://thawing-wildwood-54540.herokuapp.com/"))
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        
        let getBasket = GetBasket(baseURL: baseURL, errorParser: ErrorParser(), sessionManager: session, queue: DispatchQueue.global(qos: .utility))
        
        let getBasketProducts = expectation(description: "get basket")
        getBasket.getBasket(userID: 787) {response in
            switch response.result {
            case .success(let model):
                let productIndex = model.contents.firstIndex(where:{$0.productID == 456})
                XCTAssertEqual(model.contents[productIndex ?? 456].productID, 456)
                XCTAssertEqual(model.contents[productIndex ?? 456].productPrice, 1000)
                XCTAssertEqual(model.contents[productIndex ?? 456].productName, "Mouse")
                XCTAssertEqual(model.contents[productIndex ?? 456].productDescription, "High-precision wireless mouse for 3D graphics with customizable each button")
                XCTAssertEqual(model.contents[productIndex ?? 456].quantityInBasket, 10)
                getBasketProducts.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 20)
    }
    
    //MARK: - Negative tests
    func testFailedGetBasket() throws {
        let baseURL = try XCTUnwrap(URL(string: "https://wrongUrl.com"))
        
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        
        let getBasket = GetBasket(baseURL: baseURL, errorParser: ErrorParser(), sessionManager: session, queue: DispatchQueue.global(qos: .utility))
        
        let failedGetBasketProduct = expectation(description: "failed get basket")
        getBasket.getBasket(userID: 787) {response in
            switch response.result {
            case .success(let model):
                XCTFail("Must have failed: \(model)")
            case .failure:
                failedGetBasketProduct.fulfill()
            }
        }
        waitForExpectations(timeout: 20)
    }
}
