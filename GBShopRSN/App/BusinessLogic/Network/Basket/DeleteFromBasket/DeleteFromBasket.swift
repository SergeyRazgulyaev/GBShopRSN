//
//  DeleteFromBasket.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 02.03.2021.
//

import Foundation
import Alamofire

class DeleteFromBasket: AbstractRequestFactory {
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

extension DeleteFromBasket: DeleteFromBasketRequestFactory {
    func deleteFromBasket(deletedProductID: Int,
                          completionHandler: @escaping (AFDataResponse<DeleteFromBasketResult>) -> Void) {
        let requestModel = DeleteFromBasketRequest(baseURL: baseURL,
                                                   deletedProductID: deletedProductID)
        self.request(request: requestModel,
                     completionHandler: completionHandler)
    }
}

extension DeleteFromBasket {
    struct DeleteFromBasketRequest: RequestRouter {
        let baseURL: URL
        let method: HTTPMethod = .post
        let path: String = "deleteFromBasket"
        
        let deletedProductID: Int
        
        var parameters: Parameters? {
            return ["deleted_product_id" : deletedProductID]
        }
    }
}
