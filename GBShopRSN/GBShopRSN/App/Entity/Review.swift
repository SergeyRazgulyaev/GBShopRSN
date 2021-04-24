//
//  Review.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 26.02.2021.
//

import Foundation

struct Review: Codable {
    let commentID: Int
    let productID: Int
    let userID: Int
    let userName: String
    let userLastName: String
    let text: String
    
    enum CodingKeys: String, CodingKey {
        case commentID = "comment_id"
        case productID = "product_id"
        case userID = "user_id"
        case userName = "user_name"
        case userLastName = "user_last_name"
        case text = "text"
    }
}
