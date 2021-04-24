//
//  AddToBasket.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 01.03.2021.
//

import Foundation
import Alamofire

class AddToBasket: AbstractRequestFactory {
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

extension AddToBasket: AddToBasketRequestFactory {
    func addToBasket(addedProductID: Int,
                     updatedQuantityInBasket: Int,
                     completionHandler: @escaping (AFDataResponse<AddToBasketResult>) -> Void) {
        let requestModel = AddToBasketRequest(baseURL: baseURL,
                                              addedProductID: addedProductID,
                                              updatedQuantityInBasket: updatedQuantityInBasket)
        self.request(request: requestModel,
                     completionHandler: completionHandler)
    }
}

extension AddToBasket {
    struct AddToBasketRequest: RequestRouter {
        let baseURL: URL
        let method: HTTPMethod = .post
        let path: String = "addToBasket"
        
        let addedProductID: Int
        let updatedQuantityInBasket: Int
        
        var parameters: Parameters? {
            return [
                "added_product_id": addedProductID,
                "updated_quantity_in_basket": updatedQuantityInBasket,
            ]
        }
    }
}
