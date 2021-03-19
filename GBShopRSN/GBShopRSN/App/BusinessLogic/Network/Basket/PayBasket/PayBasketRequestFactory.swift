//
//  PayBasketRequestFactory.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 03.03.2021.
//

import Foundation
import Alamofire

protocol PayBasketRequestFactory {
    func payBasket(userID: Int,
                   payAmount: Int,
                   completionHandler: @escaping (AFDataResponse<PayBasketResult>) -> Void)
}
