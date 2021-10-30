//
//  GetBasketResult.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 02.03.2021.
//

struct GetBasketResult: Codable {
    let amount: Int
    let countGoods: Int
    let contents: [Product]
    
    enum CodingKeys: String, CodingKey {
        case amount = "amount"
        case countGoods = "count_goods"
        case contents = "contents"
    }
}
