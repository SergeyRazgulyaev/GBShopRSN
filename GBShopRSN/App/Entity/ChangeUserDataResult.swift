//
//  ChangeUserDataResult.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 17.02.2021.
//

import Foundation

struct ChangeUserDataResult: Codable {
    let result: Int
    let userID: Int
    
    enum CodingKeys: String, CodingKey {
        case result = "result"
        case userID = "user_id"
    }
}
