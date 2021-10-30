//
//  DeleteReviewRequestFactory.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 26.02.2021.
//

import Foundation
import Alamofire

protocol DeleteReviewRequestFactory {
    func deleteReview(productID: Int, commentID: Int,
                      completionHandler: @escaping (AFDataResponse<DeleteReviewResult>) -> Void)
}
