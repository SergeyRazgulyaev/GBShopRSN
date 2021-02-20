//
//  ExitUserRequestFactory.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 18.02.2021.
//

import Foundation
import Alamofire

protocol ExitUserRequestFactory {
    func logout(idUser: Int, completionHandler: @escaping (AFDataResponse<LogoutResult>) -> Void)
}
