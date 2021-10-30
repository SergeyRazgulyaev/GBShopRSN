//
//  AddReview.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 26.02.2021.
//

import Foundation
import Alamofire

class AddReview: AbstractRequestFactory {
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

extension AddReview: AddReviewRequestFactory {
    func addReview(productID: Int,
                   userID: Int,
                   userName: String,
                   userLastName: String,
                   text: String,
                   completionHandler: @escaping (AFDataResponse<AddReviewResult>) -> Void) {
        let requestModel = AddReviewRequest(baseURL: baseURL,
                                            productID: productID,
                                            userID: userID,
                                            userName: userName,
                                            userLastName: userLastName,
                                            text: text)
        self.request(request: requestModel,
                     completionHandler: completionHandler)
    }
}

extension AddReview {
    struct AddReviewRequest: RequestRouter {
        let baseURL: URL
        let method: HTTPMethod = .post
        let path: String = "addReview"
        
        let productID: Int
        let userID: Int
        let userName: String
        let userLastName: String
        let text: String
        
        var parameters: Parameters? {
            return [
                "product_id": productID,
                "user_id" : userID,
                "user_name" : userName,
                "user_last_name" : userLastName,
                "text" : text
            ]
        }
    }
}
