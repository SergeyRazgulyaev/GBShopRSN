//
//  DeleteFromBasketResult.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 02.03.2021.
//

import Foundation

struct DeleteFromBasketResult: Codable {
    let result: Int
    let deletedProductID: Int
    let deletedProductQuantityInBasket: Int
    
    enum CodingKeys: String, CodingKey {
        case result = "result"
        case deletedProductID = "deleted_product_id"
        case deletedProductQuantityInBasket = "deleted_product_quantity_in_basket"
    }
}
