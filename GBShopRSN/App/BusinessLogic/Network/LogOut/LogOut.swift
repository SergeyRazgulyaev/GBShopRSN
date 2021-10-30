//
//  LogOut.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 18.02.2021.
//

import Foundation
import Alamofire

class LogOut: AbstractRequestFactory {
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

extension LogOut: LogOutRequestFactory {
    func logOut(userID: Int,
                completionHandler: @escaping (AFDataResponse<LogOutResult>) -> Void) {
        let requestModel = LogoutRequest(baseURL: baseURL,
                                         userID: userID)
        self.request(request: requestModel,
                     completionHandler: completionHandler)
    }
}

extension LogOut {
    struct LogoutRequest: RequestRouter {
        let baseURL: URL
        let method: HTTPMethod = .post
        let path: String = "logOut"

        let userID: Int
        
        var parameters: Parameters? {
            return ["user_id" : userID]
        }
    }
}
