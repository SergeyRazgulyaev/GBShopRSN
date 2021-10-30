//
//  LogInRequestFactory.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 17.02.2021.
//

import Foundation
import Alamofire

protocol LogInRequestFactory {
    func logIn(userLogin: String,
               password: String,
               completionHandler: @escaping (AFDataResponse<LogInResult>) -> Void)
}
