//
//  RegistrationRequestFactory.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 17.02.2021.
//

import Foundation
import Alamofire

protocol RegistrationRequestFactory {
    func register(idUser: Int, userName: String, password: String, email: String, gender: String, creditCard: String, bio: String, completionHandler: @escaping (AFDataResponse<RegistrationResult>) -> Void)
}
