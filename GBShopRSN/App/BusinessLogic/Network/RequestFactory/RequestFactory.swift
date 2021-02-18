//
//  RequestFactory.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 17.02.2021.
//

import Foundation
import Alamofire

class RequestFactory {
    
    func makeErrorParser() -> AbstractErrorParser {
        return ErrorParser()
    }
    
    let baseUrl = URL(string:         "https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/")!
    
    lazy var commonSession: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let manager = Session(configuration: configuration)
        return manager
    }()
    
    let sessionQueue = DispatchQueue.global(qos: .utility)
    
    func makeRegistretionRequestFactory() -> RegistrationRequestFactory {
        let errorParser = makeErrorParser()
        return Registration(baseUrl: baseUrl, errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeAuthRequestFatory() -> AuthRequestFactory {
        let errorParser = makeErrorParser()
        return Auth(baseUrl: baseUrl, errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeChangeUserDataRequestFactory() -> ChangeUserDataRequestFactory {
        let errorParser = makeErrorParser()
        return ChangeUserData(baseUrl: baseUrl, errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeExitRequestFactory() -> ExitFromShopRequestFactory {
        let errorParser = makeErrorParser()
        return ExitFromShop(baseUrl: baseUrl, errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
}
