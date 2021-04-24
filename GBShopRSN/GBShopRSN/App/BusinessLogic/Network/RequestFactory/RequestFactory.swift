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
    let baseURL: URL
    
    //MARK: - Init
    init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    //MARK: - Methods
    func makeErrorParser() -> AbstractErrorParser {
        return ErrorParser()
    }
    
    func makeSignUpRequestFactory() -> SignUpRequestFactory {
        let errorParser = makeErrorParser()
        return SignUp(baseURL: baseURL,
                      errorParser: errorParser,
                      sessionManager: commonSession,
                      queue: sessionQueue)
    }
    
    func makeLogInRequestFactory() -> LogInRequestFactory {
        let errorParser = makeErrorParser()
        return LogIn(baseURL: baseURL,
                     errorParser: errorParser,
                     sessionManager: commonSession,
                     queue: sessionQueue)
    }
    
    func makeChangeUserDataRequestFactory() -> ChangeUserDataRequestFactory {
        let errorParser = makeErrorParser()
        return ChangeUserData(baseURL: baseURL,
                              errorParser: errorParser,
                              sessionManager: commonSession,
                              queue: sessionQueue)
    }
    
    func makeAddToBasketRequestFactory() -> AddToBasketRequestFactory {
        let errorParser = makeErrorParser()
        return AddToBasket(baseURL: baseURL,
                           errorParser: errorParser,
                           sessionManager: commonSession,
                           queue: sessionQueue)
    }
    
    func makeDeleteFromBasketRequestFactory() -> DeleteFromBasketRequestFactory {
        let errorParser = makeErrorParser()
        return DeleteFromBasket(baseURL: baseURL,
                                errorParser: errorParser,
                                sessionManager: commonSession,
                                queue: sessionQueue)
    }
    
    func makeGetBasketRequestFactory() -> GetBasketRequestFactory {
        let errorParser = makeErrorParser()
        return GetBasket(baseURL: baseURL,
                         errorParser: errorParser,
                         sessionManager: commonSession,
                         queue: sessionQueue)
    }
    
        func makePayBasketRequestFactory() -> PayBasketRequestFactory {
            let errorParser = makeErrorParser()
            return PayBasket(baseURL: baseURL,
                             errorParser: errorParser,
                             sessionManager: commonSession,
                             queue: sessionQueue)
        }
    
    func makeGetProductRequestFactory() -> GetProductRequestFactory {
        let errorParser = makeErrorParser()
        return GetProduct(baseURL: baseURL,
                          errorParser: errorParser,
                          sessionManager: commonSession,
                          queue: sessionQueue)
    }
    
    func makeGetProductListRequestFactory() -> GetProductListRequestFactory {
        let errorParser = makeErrorParser()
        return GetProductList(baseURL: baseURL,
                              errorParser: errorParser,
                              sessionManager: commonSession,
                              queue: sessionQueue)
    }
    
    func makeAddReviewRequestFactory() -> AddReviewRequestFactory {
        let errorParser = makeErrorParser()
        return AddReview(baseURL: baseURL,
                         errorParser: errorParser,
                         sessionManager: commonSession,
                         queue: sessionQueue)
    }
    
    func makeDeleteReviewRequestFactory() -> DeleteReviewRequestFactory {
        let errorParser = makeErrorParser()
        return DeleteReview(baseURL: baseURL,
                            errorParser: errorParser,
                            sessionManager: commonSession,
                            queue: sessionQueue)
    }
    
    func makeGetReviewsRequestFactory() -> GetReviewsRequestFactory {
        let errorParser = makeErrorParser()
        return GetReviews(baseURL: baseURL,
                          errorParser: errorParser,
                          sessionManager: commonSession,
                          queue: sessionQueue)
    }
    
    func makeLogOutRequestFactory() -> LogOutRequestFactory {
        let errorParser = makeErrorParser()
        return LogOut(baseURL: baseURL,
                      errorParser: errorParser,
                      sessionManager: commonSession,
                      queue: sessionQueue)
    }
}
