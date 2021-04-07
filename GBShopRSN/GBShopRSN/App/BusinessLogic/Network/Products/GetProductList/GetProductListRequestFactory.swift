//
//  GetProductListRequestFactory.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 20.02.2021.
//

import Foundation
import Alamofire

protocol GetProductListRequestFactory {
    func getProductList(pageNumber: Int,
                        idCategory: Int,
                        completionHandler: @escaping (AFDataResponse<GetProductListResult>) -> Void)
}
