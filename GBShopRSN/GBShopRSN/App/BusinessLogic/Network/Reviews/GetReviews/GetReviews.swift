//
//  GetReviews.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 26.02.2021.
//

import Foundation
import Alamofire

class GetReviews: AbstractRequestFactory {
    // MARK: - Properties
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    let baseUrl: URL
    
    // MARK: - Init
    init(baseUrl: URL, errorParser: AbstractErrorParser,
         sessionManager: Session,
         queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.baseUrl = baseUrl
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension GetReviews: GetReviewsRequestFactory {
    func getReviews(pageNumber: Int, productID: Int, completionHandler: @escaping (AFDataResponse<GetReviewsResult>) -> Void) {
        let requestModel = GetReviewsRequest(baseUrl: baseUrl, pageNumber: pageNumber, productID: productID)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension GetReviews {
    struct GetReviewsRequest: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "getReviews"
        
        let pageNumber: Int
        let productID: Int
        
        var parameters: Parameters? {
            return [
                "page_number" : pageNumber,
                "product_id" : productID
            ]
        }
    }
}
