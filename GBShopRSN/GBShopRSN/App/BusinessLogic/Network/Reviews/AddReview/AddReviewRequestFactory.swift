//
//  AddReviewRequestFactory.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 26.02.2021.
//

import Foundation
import Alamofire

protocol AddReviewRequestFactory {
    func addReview(userID: Int, text: String, completionHandler: @escaping (AFDataResponse<AddReviewResult>) -> Void)
}
