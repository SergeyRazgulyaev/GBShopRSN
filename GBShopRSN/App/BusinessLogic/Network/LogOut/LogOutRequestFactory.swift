//
//  LogOutRequestFactory.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 18.02.2021.
//

import Foundation
import Alamofire

protocol LogOutRequestFactory {
    func logOut(userID: Int,
                completionHandler: @escaping (AFDataResponse<LogOutResult>) -> Void)
}
