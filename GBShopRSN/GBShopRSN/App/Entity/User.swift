//
//  User.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 17.02.2021.
//

import Foundation

struct User: Codable {
    let id: Int
    let login: String
    let name: String
    let lastname: String
    
    enum CodingKeys: String, CodingKey {
        case id = "user_id"
        case login = "user_login"
        case name = "user_name"
        case lastname = "user_lastname"
    }
}
