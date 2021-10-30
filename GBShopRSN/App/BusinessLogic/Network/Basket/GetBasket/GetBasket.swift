//
//  GetBasket.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 02.03.2021.
//

import Foundation
import Alamofire

class GetBasket: AbstractRequestFactory {
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

extension GetBasket: GetBasketRequestFactory {
    func getBasket(userID: Int,
                   completionHandler: @escaping (AFDataResponse<GetBasketResult>) -> Void) {
        let requestModel = GetBasketRequest(baseURL: baseURL,
                                            userID: userID)
        self.request(request: requestModel,
                     completionHandler: completionHandler)
    }
}

extension GetBasket {
    struct GetBasketRequest: RequestRouter {
        let baseURL: URL
        let method: HTTPMethod = .post
        let path: String = "getBasket"

        let userID: Int

        var parameters: Parameters? {
            return ["user_id" : userID]
        }
    }
}
