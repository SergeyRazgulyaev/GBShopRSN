//
//  RequestFactory.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 17.02.2021.
//

import Foundation
import Alamofire

class RequestFactory {
    // MARK: - Properties
    lazy var commonSession: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let manager = Session(configuration: configuration)
        return manager
    }()
    
    let sessionQueue = DispatchQueue.global(qos: .utility)
    let baseUrl: URL
    
    //MARK: - Init
    init(baseUrl: URL) {
        self.baseUrl = baseUrl
    }
    
    func makeErrorParser() -> AbstractErrorParser {
        return ErrorParser()
    }
    
    func makeSignUpRequestFactory() -> SignUpRequestFactory {
        let errorParser = makeErrorParser()
        return SignUp(baseUrl: baseUrl, errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeLogInRequestFactory() -> LogInRequestFactory {
        let errorParser = makeErrorParser()
        return LogIn(baseUrl: baseUrl, errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeChangeUserDataRequestFactory() -> ChangeUserDataRequestFactory {
        let errorParser = makeErrorParser()
        return ChangeUserData(baseUrl: baseUrl, errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeAddToBasketRequestFactory() -> AddToBasketRequestFactory {
        let errorParser = makeErrorParser()
        return AddToBasket(baseUrl: baseUrl, errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeDeleteFromBasketRequestFactory() -> DeleteFromBasketRequestFactory {
        let errorParser = makeErrorParser()
        return DeleteFromBasket(baseUrl: baseUrl, errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeGetBasketRequestFactory() -> GetBasketRequestFactory {
        let errorParser = makeErrorParser()
        return GetBasket(baseUrl: baseUrl, errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
    
        func makePayBasketRequestFactory() -> PayBasketRequestFactory {
            let errorParser = makeErrorParser()
            return PayBasket(baseUrl: baseUrl, errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
        }
    
    func makeGetProductRequestFactory() -> GetProductRequestFactory {
        let errorParser = makeErrorParser()
        return GetProduct(baseUrl: baseUrl, errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeGetProductListRequestFactory() -> GetProductListRequestFactory {
        let errorParser = makeErrorParser()
        return GetProductList(baseUrl: baseUrl, errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeAddReviewRequestFactory() -> AddReviewRequestFactory {
        let errorParser = makeErrorParser()
        return AddReview(baseUrl: baseUrl, errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeDeleteReviewRequestFactory() -> DeleteReviewRequestFactory {
        let errorParser = makeErrorParser()
        return DeleteReview(baseUrl: baseUrl, errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeGetReviewsRequestFactory() -> GetReviewsRequestFactory {
        let errorParser = makeErrorParser()
        return GetReviews(baseUrl: baseUrl, errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeLogOutRequestFactory() -> LogOutRequestFactory {
        let errorParser = makeErrorParser()
        return LogOut(baseUrl: baseUrl, errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
}
