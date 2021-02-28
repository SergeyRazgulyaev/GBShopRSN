//
//  GetProductRequestFactory.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 21.02.2021.
//

import Foundation
import Alamofire

protocol GetProductRequestFactory {
    func getProduct(idProduct: Int, completionHandler: @escaping (AFDataResponse<GetProductResult>) -> Void)
}
