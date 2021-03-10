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
//        let baseURL = try XCTUnwrap(URL(string: "http://127.0.0.1:8080"))
        let baseURL = try XCTUnwrap(URL(string: "https://thawing-wildwood-54540.herokuapp.com/"))
        
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        
        let getBasket = GetBasket(baseUrl: baseURL, errorParser: ErrorParser(), sessionManager: session, queue: DispatchQueue.global(qos: .utility))
        
        let getBasketProducts = expectation(description: "get basket")
        getBasket.getBasket(userID: 123) {response in
            switch response.result {
            case .success(let model):
                XCTAssertEqual(model.amount, 46600)
                XCTAssertEqual(model.countGoods, 2)
                XCTAssertEqual(model.contents[0].productID, 123)
                XCTAssertEqual(model.contents[0].productPrice, 45600)
                XCTAssertEqual(model.contents[0].productName, "Notebook")
                XCTAssertEqual(model.contents[0].productDescription, "Powerful gaming notebook")
                XCTAssertEqual(model.contents[0].quantityInBasket, 1)
                XCTAssertEqual(model.contents[1].productID, 456)
                XCTAssertEqual(model.contents[1].productPrice, 1000)
                XCTAssertEqual(model.contents[1].productName, "Mouse")
                XCTAssertEqual(model.contents[1].productDescription, "High-precision mouse for 3D graphics")
                XCTAssertEqual(model.contents[1].quantityInBasket, 1)
                getBasketProducts.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10)
    }
    
    //MARK: - Negative tests
    func testFailedGetBasket() throws {
        let baseURL = try XCTUnwrap(URL(string: "https://wrongUrl.com"))
        
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        
        let getBasket = GetBasket(baseUrl: baseURL, errorParser: ErrorParser(), sessionManager: session, queue: DispatchQueue.global(qos: .utility))
        
        let failedGetBasketProduct = expectation(description: "failed get basket")
        getBasket.getBasket(userID: 123) {response in
            switch response.result {
            case .success(let model):
                XCTFail("Must have failed: \(model)")
            case .failure:
                failedGetBasketProduct.fulfill()
            }
        }
        waitForExpectations(timeout: 10)
    }
}
