//
//  AddToBasket.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 01.03.2021.
//

import Foundation
import Alamofire

class AddToBasket: AbstractRequestFactory {
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

extension AddToBasket: AddToBasketRequestFactory {
    func addToBasket(productID: Int, quantityInBasket: Int, completionHandler: @escaping (AFDataResponse<AddToBasketResult>) -> Void) {
        let requestModel = AddToBasketRequest(baseUrl: baseUrl, productID: productID, quantityInBasket: quantityInBasket)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension AddToBasket {
    struct AddToBasketRequest: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "addToBasket"
        
        let productID: Int
        let quantityInBasket: Int
        
        var parameters: Parameters? {
            return [
                "product_id" : productID,
                "quantity_in_basket" : quantityInBasket,
            ]
        }
    }
}
