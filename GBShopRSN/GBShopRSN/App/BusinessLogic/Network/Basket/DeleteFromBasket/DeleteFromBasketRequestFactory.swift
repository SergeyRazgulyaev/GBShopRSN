//
//  DeleteFromBasketRequestFactory.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 02.03.2021.
//

import Foundation
import Alamofire

protocol DeleteFromBasketRequestFactory {
    func deleteFromBasket(productID: Int,
                          completionHandler: @escaping (AFDataResponse<DeleteFromBasketResult>) -> Void)
}
