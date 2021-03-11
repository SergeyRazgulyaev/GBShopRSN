//
//  AddReview.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 26.02.2021.
//

import Foundation
import Alamofire

class AddReview: AbstractRequestFactory {
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

extension AddReview: AddReviewRequestFactory {
    func addReview(userID: Int, text: String, completionHandler: @escaping (AFDataResponse<AddReviewResult>) -> Void) {
        let requestModel = AddReviewRequest(baseUrl: baseUrl, userID: userID, text: text)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension AddReview {
    struct AddReviewRequest: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "addReview"
        
        let userID: Int
        let text: String
        
        var parameters: Parameters? {
            return [
                "user_id" : userID,
                "text" : text
            ]
        }
    }
}
