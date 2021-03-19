//
//  DeleteReviewRequestFactory.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 26.02.2021.
//

import Foundation
import Alamofire

protocol DeleteReviewRequestFactory {
    func deleteReview(idComment: Int,
                      completionHandler: @escaping (AFDataResponse<DeleteReviewResult>) -> Void)
}
