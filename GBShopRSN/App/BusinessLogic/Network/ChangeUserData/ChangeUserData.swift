//
//  ChangeUserData.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 18.02.2021.
//

import Foundation
import Alamofire

class ChangeUserData: AbstractRequestFactory {
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

extension ChangeUserData: ChangeUserDataRequestFactory {
    func changeUserData(userID: Int,
                        userName: String,
                        userLastName: String,
                        password: String,
                        email: String,
                        gender: String,
                        creditCard: String,
                        bio: String,
                        completionHandler: @escaping (AFDataResponse<ChangeUserDataResult>) -> Void) {
        let requestModel = ChangeUserDataRequest(baseURL: baseURL,
                                                 userID: userID,
                                                 userName: userName,
                                                 userLastName: userLastName,
                                                 password: password,
                                                 email: email,
                                                 gender: gender,
                                                 creditCard: creditCard,
                                                 bio: bio)
        self.request(request: requestModel,
                     completionHandler: completionHandler)
    }
}

extension ChangeUserData {
    struct ChangeUserDataRequest: RequestRouter {
        let baseURL: URL
        let method: HTTPMethod = .post
        let path: String = "changeUserData"
        
        let userID: Int
        let userName: String
        let userLastName: String
        let password: String
        let email: String
        let gender: String
        let creditCard: String
        let bio: String
        
        var parameters: Parameters? {
            return [
                "user_id" : userID,
                "user_name" : userName,
                "user_last_name" : userLastName,
                "password" : password,
                "email" : email,
                "gender": gender,
                "credit_card" : creditCard,
                "bio" : bio
            ]
        }
    }
}
