//
//  AddToBasketResult.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 01.03.2021.
//

import Foundation

struct AddToBasketResult: Codable {
    let result: Int
    let addedProductID: Int
    let updatedQuantityInBasket: Int
    
    enum CodingKeys: String, CodingKey {
        case result = "result"
        case addedProductID = "added_product_id"
        case updatedQuantityInBasket = "updated_quantity_in_basket"
    }
}
