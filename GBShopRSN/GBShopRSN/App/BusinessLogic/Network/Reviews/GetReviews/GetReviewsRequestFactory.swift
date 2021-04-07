//
//  GetReviewsRequestFactory.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 26.02.2021.
//

import Foundation
import Alamofire

protocol GetReviewsRequestFactory {
    func getReviews(pageNumber: Int,
                    productID: Int,
                    completionHandler: @escaping (AFDataResponse<GetReviewsResult>) -> Void)
}
