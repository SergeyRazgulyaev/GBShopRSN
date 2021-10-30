//
//  DeleteReviewResult.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 26.02.2021.
//

import Foundation

struct DeleteReviewResult: Codable {
    let result: Int
    let deletedReviewID: Int
    
    enum CodingKeys: String, CodingKey {
        case result = "result"
        case deletedReviewID = "deleted_review_id"
    }
}
