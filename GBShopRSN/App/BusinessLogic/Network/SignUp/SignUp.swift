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

extension SignUp: SignUpRequestFactory {
    func signUp(userID: Int,
                userLogin: String,
                userName: String,
                userLastName: String,
                password: String,
                email: String,
                gender: String,
                creditCard: String,
                bio: String,
                completionHandler: @escaping (AFDataResponse<SignUpResult>) -> Void) {
        let requestModel = SignUpRequest(baseURL: baseURL,
                                         userID: userID,
                                         userLogin: userLogin,
                                         userName: userName,
                                         userLastName: userLastName,
                                         email: email,
                                         gender: gender,
                                         creditCard: creditCard,
                                         bio: bio,
                                         password: password)
        self.request(request: requestModel,
                     completionHandler: completionHandler)
    }
}

extension SignUp {
    struct SignUpRequest: RequestRouter {
        let baseURL: URL
        let method: HTTPMethod = .post
        let path: String = "signUp"
        
        let userID: Int
        let userLogin: String
        let userName: String
        let userLastName: String
        let email: String
        let gender: String
        let creditCard: String
        let bio: String
        let password: String

        var parameters: Parameters? {
            return [
                "user_id": userID,
                "user_login": userLogin,
                "user_name": userName,
                "user_last_name": userLastName,
                "email": email,
                "gender": gender,
                "credit_card": creditCard,
                "bio": bio,
                "password": password
            ]
        }
    }
}
