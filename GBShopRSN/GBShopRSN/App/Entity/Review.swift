//
//  Review.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 26.02.2021.
//

import Foundation

struct Review: Codable {
    let commentID: Int
    let userID: Int
    let text: String
    
    enum CodingKeys: String, CodingKey {
        case commentID = "comment_id"
        case userID = "user_id"
        case text = "text"
    }
}
