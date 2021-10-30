//
//  SignUpResult.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 17.02.2021.
//

import Foundation

struct SignUpResult: Codable {
    let result: Int
    let assignedUserId: Int
    let signedUpUserLogin: String
    let signedUpUserName: String
    let signedUpUserLastName: String
    let signedUpEmail: String
    let signedUpGender: String
    let signedUpCreditCard: String
    let signedUpBio: String
    let userMessage: String
    
    enum CodingKeys: String, CodingKey {
        case result = "result"
        case assignedUserId = "assigned_user_id"
        case signedUpUserLogin = "signed_up_user_login"
        case signedUpUserName = "signed_up_user_name"
        case signedUpUserLastName = "signed_up_user_last_name"
        case signedUpEmail = "signed_up_email"
        case signedUpGender = "signed_up_gender"
        case signedUpCreditCard = "signed_up_credit_card"
        case signedUpBio = "signed_up_bio"
        case userMessage = "user_message"
    }
}
