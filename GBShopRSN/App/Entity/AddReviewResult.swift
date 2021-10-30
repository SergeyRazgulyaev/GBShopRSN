//
//  AddReviewResult.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 26.02.2021.
//

import Foundation

struct AddReviewResult: Codable {
    let result: Int
    let assignedСommentID: Int
    let userMessage: String

    enum CodingKeys: String, CodingKey {
        case result = "result"
        case assignedСommentID = "assigned_comment_id"
        case userMessage = "user_message"
    }
}
