//
//  DeleteFromBasket.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 02.03.2021.
//

import Foundation
import Alamofire

class DeleteFromBasket: AbstractRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    let baseUrl: URL
    
    init(baseUrl: URL, errorParser: AbstractErrorParser,
         sessionManager: Session,
         queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.baseUrl = baseUrl
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension DeleteFromBasket: DeleteFromBasketRequestFactory {
    func deleteFromBasket(productID: Int, completionHandler: @escaping (AFDataResponse<DeleteFromBasketResult>) -> Void) {
        let requestModel = DeleteFromBasketRequest(baseUrl: baseUrl, productID: productID)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension DeleteFromBasket {
    struct DeleteFromBasketRequest: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "deleteFromBasket"
        
        let productID: Int
        
        var parameters: Parameters? {
            return [
                "product_id" : productID
            ]
        }
    }
}
