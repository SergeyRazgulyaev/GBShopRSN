//
//  GetProductListResult.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 21.02.2021.
//

import Foundation

struct GetProductListResult: Codable {
    let pageNumber: Int
    let productList: [Product]
    
    enum CodingKeys: String, CodingKey {
        case pageNumber = "page_number"
        case productList = "product_list"
    }
}
