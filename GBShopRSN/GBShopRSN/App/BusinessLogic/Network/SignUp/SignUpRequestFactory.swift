//
//  SignUpRequestFactory.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 17.02.2021.
//

import Foundation
import Alamofire

protocol SignUpRequestFactory {
    func signUp(userID: Int,
                userLogin: String,
                userName: String,
                userLastName: String,
                password: String,
                email: String,
                gender: String,
                creditCard: String,
                bio: String,
                completionHandler: @escaping (AFDataResponse<SignUpResult>) -> Void)
}
