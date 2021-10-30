//
//  GetProduct.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 21.02.2021.
//

import Foundation
import Alamofire

class GetProduct: AbstractRequestFactory {
    // MARK: - Properties
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    let baseURL: URL
    
    // MARK: - Init
    init(baseURL: URL, errorParser: AbstractErrorParser,
         sessionManager: Session,
         queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.baseURL = baseURL
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension GetProduct: GetProductRequestFactory {
    func getProduct(productID: Int,
                    completionHandler: @escaping (AFDataResponse<GetProductResult>) -> Void) {
        let requestModel = GetProductRequest(baseURL: baseURL,
                                             productID: productID)
        self.request(request: requestModel,
                     completionHandler: completionHandler)
    }
}

extension GetProduct {
    struct GetProductRequest: RequestRouter {
        let baseURL: URL
        let method: HTTPMethod = .post
        let path: String = "getProduct"
        
        let productID: Int
        
        var parameters: Parameters? {
            return [ "product_id": productID ]
        }
    }
}
