//
//  DeleteReview.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 26.02.2021.
//

import Foundation
import Alamofire

class DeleteReview: AbstractRequestFactory {
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

extension DeleteReview: DeleteReviewRequestFactory {
    func deleteReview(productID: Int,
                      commentID: Int,
                      completionHandler: @escaping (AFDataResponse<DeleteReviewResult>) -> Void) {
        let requestModel = DeleteReviewRequest(baseURL: baseURL,
                                               productID: productID,
                                               commentID: commentID)
        self.request(request: requestModel,
                     completionHandler: completionHandler)
    }
}

extension DeleteReview {
    struct DeleteReviewRequest: RequestRouter {
        let baseURL: URL
        let method: HTTPMethod = .post
        let path: String = "deleteReview"
        
        let productID: Int
        let commentID: Int
        
        var parameters: Parameters? {
            return [
            "product_id" : productID,
            "comment_id" : commentID
            ]
        }
    }
}
