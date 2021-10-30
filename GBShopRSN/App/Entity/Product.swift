//
//  Product.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 20.02.2021.
//

import Foundation

struct Product: Codable {
    let productID: Int
    let productName: String
    let productPrice: Int
    let productDescription: String
    var quantityInBasket: Int
    
    enum CodingKeys: String, CodingKey {
        case productID = "product_id"
        case productName = "product_name"
        case productPrice = "product_price"
        case productDescription = "product_description"
        case quantityInBasket = "quantity_in_basket"
    }
}
