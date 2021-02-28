//
//  DeleteReview.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 26.02.2021.
//

import Foundation
import Alamofire

class DeleteReview: AbstractRequestFactory {
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

extension DeleteReview: DeleteReviewRequestFactory {
    func deleteReview(idComment: Int, completionHandler: @escaping (AFDataResponse<DeleteReviewResult>) -> Void) {
        let requestModel = DeleteReviewRequest(baseUrl: baseUrl, idComment: idComment)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension DeleteReview {
    struct DeleteReviewRequest: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "deleteReview"
        
        let idComment: Int
        
        var parameters: Parameters? {
            return [
                "id_comment" : idComment
            ]
        }
    }
}
