//
//  PayBasketResult.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 03.03.2021.
//

struct PayBasketResult: Codable {
    let result: Int
    let accountBalance: Int
    
    enum CodingKeys: String, CodingKey {
        case result = "result"
        case accountBalance = "account_balance"
    }
}
