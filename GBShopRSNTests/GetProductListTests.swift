//
//  GetProductListTests.swift
//  GBShopRSNTests
//
//  Created by Sergey Razgulyaev on 20.02.2021.
//

import XCTest
import Alamofire
@testable import GBShopRSN

class GetProductListTests: XCTestCase {
    
    //MARK: - Positive tests
    func testGetProductList() throws {
        let baseURL = try XCTUnwrap(URL(string: "https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/"))
        
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        
        let getProductList = GetProductList(baseUrl: baseURL, errorParser: ErrorParser(), sessionManager: session, queue: DispatchQueue.global(qos: .utility))
        
        let receivedProductList = expectation(description: "received product list")
        getProductList.getProductList(pageNumber: 1, idCategory: 1) {response in
            switch response.result {
            case .success(let model):
                XCTAssertEqual(model[0].idProduct, 123)
                XCTAssertEqual(model[0].productName, "Ноутбук")
                XCTAssertEqual(model[0].price, 45600)
                XCTAssertEqual(model[1].idProduct, 456)
                XCTAssertEqual(model[1].productName, "Мышка")
                XCTAssertEqual(model[1].price, 1000)
                receivedProductList.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10)
    }
    
    //MARK: - Negative tests
    func testFailedGetProductList() throws {
        let baseURL = try XCTUnwrap(URL(string: "https://wrongUrl.com"))
        
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        
        let getProductList = GetProductList(baseUrl: baseURL, errorParser: ErrorParser(), sessionManager: session, queue: DispatchQueue.global(qos: .utility))
        
        let failedReceiveProductList = expectation(description: "failed receive product list")
        getProductList.getProductList(pageNumber: 1, idCategory: 1) {response in
            switch response.result {
            case .success(let model):
                XCTFail("must have failed: \(model)")
            case .failure:
                failedReceiveProductList.fulfill()
            }
        }
        waitForExpectations(timeout: 10)
    }
}
