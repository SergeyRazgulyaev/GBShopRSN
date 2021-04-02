//
//  User.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 17.02.2021.
//

import Foundation

struct User: Codable {
    let userID: Int
    let userLogin: String
    let userName: String
    let userLastName: String
    let email: String
    let gender: String
    let creditCard: String
    let bio: String
    let accountBalance: Int
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case userLogin = "user_login"
        case userName = "user_name"
        case userLastName = "user_last_name"
        case email = "email"
        case gender = "gender"
        case creditCard = "credit_card"
        case bio = "bio"
        case accountBalance = "account_balance"
    }
}
