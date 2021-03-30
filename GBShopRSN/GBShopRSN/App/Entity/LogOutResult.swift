//
//  LogOutResult.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 17.02.2021.
//

import Foundation

struct LogOutResult: Codable {
    let result: Int
    let loggedOutUserID: Int
    
    enum CodingKeys: String, CodingKey {
        case result = "result"
        case loggedOutUserID = "logged_out_user_id"
    }
}
