//
//  GetProductList.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 20.02.2021.
//

import Foundation
import Alamofire

class GetProductList: AbstractRequestFactory {
    // MARK: - Properties
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    let baseURL: URL
    
    // MARK: - Init
    init(baseURL: URL, errorParser: AbstractErrorParser,
         sessionManager: Session,
         queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.baseURL = baseURL
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension GetProductList: GetProductListRequestFactory {
    func getProductList(pageNumber: Int,
                        idCategory: Int,
                        completionHandler: @escaping (AFDataResponse<GetProductListResult>) -> Void) {
        let requestModel = GetProductListRequest(baseURL: baseURL,
                                                 pageNumber: pageNumber,
                                                 idCategory: idCategory)
        self.request(request: requestModel,
                     completionHandler: completionHandler)
    }
}

extension GetProductList {
    struct GetProductListRequest: RequestRouter {
        let baseURL: URL
        let method: HTTPMethod = .post
        let path: String = "getProductList"
        
        let pageNumber: Int
        let idCategory: Int
        
        var parameters: Parameters? {
            return [
                "page_number" : pageNumber,
                "id_category" : idCategory,
            ]
        }
    }
}
