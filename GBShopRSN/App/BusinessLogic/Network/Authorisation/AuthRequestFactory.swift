//
//  AuthRequestFactory.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 17.02.2021.
//

import Foundation
import Alamofire

protocol AuthRequestFactory {
    func logIn(userName: String, password: String, completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void)
}
