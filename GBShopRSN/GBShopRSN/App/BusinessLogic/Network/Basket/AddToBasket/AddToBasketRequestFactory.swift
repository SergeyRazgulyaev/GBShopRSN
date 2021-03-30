//
//  AddToBasketRequestFactory.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 01.03.2021.
//

import Foundation
import Alamofire

protocol AddToBasketRequestFactory {
    func addToBasket(addedProductID: Int,
                     updatedQuantityInBasket: Int,
                     completionHandler: @escaping (AFDataResponse<AddToBasketResult>) -> Void)
}
