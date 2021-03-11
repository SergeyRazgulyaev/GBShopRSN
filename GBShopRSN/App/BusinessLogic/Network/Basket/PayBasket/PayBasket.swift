//
//  PayBasket.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 03.03.2021.
//

import Foundation
import Alamofire

class PayBasket: AbstractRequestFactory {
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

extension PayBasket: PayBasketRequestFactory {
    func payBasket(userID: Int, payAmount: Int, completionHandler: @escaping (AFDataResponse<PayBasketResult>) -> Void) {
        let requestModel = PayBasketRequest(baseUrl: baseUrl, userID: userID, payAmount: payAmount)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension PayBasket {
    struct PayBasketRequest: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "payBasket"

        let userID: Int
        let payAmount: Int

        var parameters: Parameters? {
            return [
                "user_id" : userID,
                "pay_amount" : payAmount
            ]
        }
    }
}
