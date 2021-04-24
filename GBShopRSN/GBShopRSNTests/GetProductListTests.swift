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
        let baseURL = try XCTUnwrap(URL(string: "https://thawing-wildwood-54540.herokuapp.com/"))        
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        
        let getProductList = GetProductList(baseURL: baseURL, errorParser: ErrorParser(), sessionManager: session, queue: DispatchQueue.global(qos: .utility))
        
        let receivedProductList = expectation(description: "received product list")
        getProductList.getProductList(pageNumber: 1, idCategory: 1) {response in
            switch response.result {
            case .success(let model):
                XCTAssertEqual(model.pageNumber, 1)
                XCTAssertEqual(model.productList[0].productID, 123)
                XCTAssertEqual(model.productList[0].productName, "Notebook")
                XCTAssertEqual(model.productList[0].productPrice, 45600)
                XCTAssertEqual(model.productList[1].productID, 456)
                XCTAssertEqual(model.productList[1].productName, "Mouse")
                XCTAssertEqual(model.productList[1].productPrice, 1000)
                receivedProductList.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 20)
    }
    
    //MARK: - Negative tests
    func testFailedGetProductList() throws {
        let baseURL = try XCTUnwrap(URL(string: "https://wrongUrl.com"))
        
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        
        let getProductList = GetProductList(baseURL: baseURL, errorParser: ErrorParser(), sessionManager: session, queue: DispatchQueue.global(qos: .utility))
        
        let failedReceiveProductList = expectation(description: "failed receive product list")
        getProductList.getProductList(pageNumber: 1, idCategory: 1) {response in
            switch response.result {
            case .success(let model):
                XCTFail("must have failed: \(model)")
            case .failure:
                failedReceiveProductList.fulfill()
            }
        }
        waitForExpectations(timeout: 20)
    }
}
