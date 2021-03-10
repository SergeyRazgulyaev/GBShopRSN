//
//  Review.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 26.02.2021.
//

import Foundation

struct Review: Codable {
    let idComment: Int
    let userID: Int
    let text: String
    
    enum CodingKeys: String, CodingKey {
        case idComment = "id_comment"
        case userID = "user_id"
        case text = "text"
    }
}
