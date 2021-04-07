//
//  SignUp.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 18.02.2021.
//

import Foundation
import Alamofire

class SignUp: AbstractRequestFactory {
    // MARK: - Properties
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    let baseUrl: URL
    
    // MARK: - Init
    init(baseUrl: URL, errorParser: AbstractErrorParser,
         sessionManager: Session,
         queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.baseUrl = baseUrl
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension SignUp: SignUpRequestFactory {
    func signUp(userID: Int,
                userName: String,
                password: String,
                email: String,
                gender: String,
                creditCard: String,
                bio: String,
                completionHandler: @escaping (AFDataResponse<SignUpResult>) -> Void) {
        let requestModel = SignUpRequest(baseUrl: baseUrl,
                                         userID: userID,
                                         userName: userName,
                                         password: password,
                                         email: email,
                                         gender: gender,
                                         creditCard: creditCard,
                                         bio: bio)
        self.request(request: requestModel,
                     completionHandler: completionHandler)
    }
}

extension SignUp {
    struct SignUpRequest: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "signUp"
        
        let userID: Int
        let userName: String
        let password: String
        let email: String
        let gender: String
        let creditCard: String
        let bio: String
        
        var parameters: Parameters? {
            return [
                "user_id" : userID,
                "username" : userName,
                "password" : password,
                "email" : email,
                "gender": gender,
                "credit_card" : creditCard,
                "bio" : bio
            ]
        }
    }
}
