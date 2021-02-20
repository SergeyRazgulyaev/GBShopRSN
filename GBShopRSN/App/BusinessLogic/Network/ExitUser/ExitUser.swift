//
//  ExitUser.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 18.02.2021.
//

import Foundation
import Alamofire

class ExitUser: AbstractRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    let baseUrl: URL
    
    init(baseUrl: URL, errorParser: AbstractErrorParser,
         sessionManager: Session,
         queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.baseUrl = baseUrl
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension ExitUser: ExitUserRequestFactory {
    func logout(idUser: Int, completionHandler: @escaping (AFDataResponse<LogoutResult>) -> Void) {
        let requestModel = Logout(baseUrl: baseUrl, idUser: idUser)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension ExitUser {
    struct Logout: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "logout.json"
        
        let idUser: Int
        var parameters: Parameters? {
            return ["id_user" : idUser]
        }
    }
}
