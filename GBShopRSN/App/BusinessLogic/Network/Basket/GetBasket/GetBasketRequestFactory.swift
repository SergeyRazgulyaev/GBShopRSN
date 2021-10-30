//
//  GetBasketRequestFactory.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 02.03.2021.
//

import Foundation
import Alamofire

protocol GetBasketRequestFactory {
    func getBasket(userID: Int,
                   completionHandler: @escaping (AFDataResponse<GetBasketResult>) -> Void)
}
