//
//  LogIn.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 17.02.2021.
//

import Foundation
import Alamofire

class LogIn: AbstractRequestFactory {
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

extension LogIn: LogInRequestFactory {
    func logIn(userLogin: String,
               password: String,
               completionHandler: @escaping (AFDataResponse<LogInResult>) -> Void) {
        let requestModel = LoginRequest(baseURL: baseURL,
                                        userLogin: userLogin,
                                        password: password)
        self.request(request: requestModel,
                     completionHandler: completionHandler)
    }
}

extension LogIn {
    struct LoginRequest: RequestRouter {
        let baseURL: URL
        let method: HTTPMethod = .post
        let path: String = "logIn"
        
        let userLogin: String
        let password: String
        var parameters: Parameters? {
            return [
                "user_login": userLogin,
                "password": password
            ]
        }
    }
}
