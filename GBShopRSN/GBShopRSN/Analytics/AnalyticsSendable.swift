//
//  AnalyticsSendable.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 28.03.2021.
//

import UIKit
import FirebaseAnalytics

protocol AnalyticsSendable {
    func sendAnalyticsSignUpSuccess(viewController: SignUpScreenViewController, assignedUserId: Int, signedUpUserName: String, signedUpUserLastName: String, signedUpEmail: String, signedUpGender: String, signedUpCreditCard: String, signedUpBio: String, userMessage: String) -> Void
    
    func sendAnalyticsLogInSuccess(viewController: LogInScreenViewController, userID: Int, userName: String, userLastname: String) -> Void
    
    func sendAnalyticsLogOutSuccess(viewController: UserInfoScreenViewController, userID: Int) -> Void

    func sendAnalyticsOpenProductListSuccess(viewController: ProductListScreenViewController, productListCount: Int) -> Void
    
    func sendAnalyticsOpenProductSuccess(viewController: ProductScreenViewController, productID: Int, productName: String, productPrice: Int, productDescription: String, quantityInBasket: Int) -> Void
    
    func sendAnalyticsGetBasketSuccess(viewController: BasketScreenViewController, userID: Int, amount: Int, typeOfGoodsCount: Int) -> Void
   
    func sendAnalyticsAddToBasketSuccess(viewController: ProductScreenViewController, addedProductID: Int, updatedQuantityInBasket: Int) -> Void
    
    func sendAnalyticsDeleteFromBasketSuccess(viewController: UIViewController, deletedProductID: Int, deletedProductQuantityInBasket: Int) -> Void
    
    func sendAnalyticsPayBasketSuccess(viewController: BasketScreenViewController, userID: Int, payAmount: Int) -> Void
    
    func sendAnalyticsGetReviewsSuccess(viewController: ProductScreenViewController, reviewsCount: Int) -> Void
    
    func sendAnalyticsAddReviewSuccess(viewController: ProductScreenViewController, userMessage: String) -> Void
    
    func sendAnalyticsDeleteReviewSuccess(viewController: ProductScreenViewController) -> Void
    
    func sendAnalyticsChangeUserDataSuccess(viewController: UserInfoScreenViewController, userID: Int) -> Void
    
    func sendAnalyticsFailure(failureName: String, viewController: UIViewController, errorDescription: String) -> Void
}

extension AnalyticsSendable {
    func sendAnalyticsSignUpSuccess(viewController: SignUpScreenViewController, assignedUserId: Int, signedUpUserName: String, signedUpUserLastName: String, signedUpEmail: String, signedUpGender: String, signedUpCreditCard: String, signedUpBio: String, userMessage: String) -> Void {
        Analytics.logEvent("sign_up_success",
                           parameters: [
                            AnalyticsParameterMethod: viewController.method,
                            "assigned_user_id": assignedUserId,
                            "signed_up_user_name": signedUpUserName,
                            "signed_up_user_last_name": signedUpUserLastName,
                            "signed_up_email": signedUpEmail,
                            "signed_up_gender": signedUpGender,
                            "signed_up_credit_card": signedUpCreditCard,
                            "signed_up_bio": signedUpBio,
                            "user_message": userMessage])
    }
    
    func sendAnalyticsLogInSuccess(viewController: LogInScreenViewController, userID: Int, userName: String, userLastname: String) -> Void {
        Analytics.logEvent("log_in_success",
                           parameters: [
                            AnalyticsParameterMethod: viewController.method,
                            "logged_in_user_id": userID,
                            "logged_in_user_name": userName,
                            "logged_in_user_lastname": userLastname])
    }
    
    func sendAnalyticsLogOutSuccess(viewController: UserInfoScreenViewController, userID: Int) -> Void {
        Analytics.logEvent("log_out_success",
                           parameters: [
                            AnalyticsParameterMethod: viewController.method,
                            "user_id": userID])
    }
    
    func sendAnalyticsOpenProductListSuccess(viewController: ProductListScreenViewController, productListCount: Int) -> Void {
        Analytics.logEvent("open_product_list_success",
                           parameters: [
                            AnalyticsParameterMethod: viewController.method,
                            "product_list_count": productListCount])
    }
    
    func sendAnalyticsOpenProductSuccess(viewController: ProductScreenViewController, productID: Int, productName: String, productPrice: Int, productDescription: String, quantityInBasket: Int) -> Void {
        Analytics.logEvent("open_product_success",
                           parameters: [
                            AnalyticsParameterMethod: viewController.method,
                            "product_id": productID,
                            "product_name": productName,
                            "product_price": productPrice,
                            "product_description": productDescription,
                            "quantity_in_basket": quantityInBasket])
    }
    
    func sendAnalyticsGetBasketSuccess(viewController: BasketScreenViewController, userID: Int, amount: Int, typeOfGoodsCount: Int) -> Void {
        Analytics.logEvent("get_basket_success",
                           parameters: [
                            AnalyticsParameterMethod: viewController.method,
                            "user_id": userID,
                            "amount": amount,
                            "type_of_goods_count": typeOfGoodsCount])
    }
    
    func sendAnalyticsAddToBasketSuccess(viewController: ProductScreenViewController, addedProductID: Int, updatedQuantityInBasket: Int) -> Void {
        Analytics.logEvent("add_to_basket_success",
                           parameters: [
                            AnalyticsParameterMethod: viewController.method,
                            "added_product_id": addedProductID,
                            "updated_quantity_in_basket": updatedQuantityInBasket])
    }
    
    func sendAnalyticsDeleteFromBasketSuccess(viewController: UIViewController, deletedProductID: Int, deletedProductQuantityInBasket: Int) -> Void {
        Analytics.logEvent("delete_from_basket_success",
                           parameters: [
                            AnalyticsParameterMethod: viewController.method,
                            "deleted_product_id": deletedProductID,
                            "deleted_product_quantity_in_basket": deletedProductQuantityInBasket])
    }
    
    func sendAnalyticsPayBasketSuccess(viewController: BasketScreenViewController, userID: Int, payAmount: Int) -> Void {
        Analytics.logEvent("pay_basket_success",
                           parameters: [AnalyticsParameterMethod: viewController.method,
                                        "user_id": userID,
                                        "pay_amount": payAmount])
    }
    
    func sendAnalyticsGetReviewsSuccess(viewController: ProductScreenViewController, reviewsCount: Int) -> Void {
        Analytics.logEvent("get_reviews_success",
                           parameters: [
                            AnalyticsParameterMethod: viewController.method,
                            "reviews_count": reviewsCount])
    }
    
    func sendAnalyticsAddReviewSuccess(viewController: ProductScreenViewController, userMessage: String) -> Void {
        Analytics.logEvent("add_review_success",
                           parameters: [
                            AnalyticsParameterMethod: viewController.method,
                            "user_message": userMessage])
    }
    
    func sendAnalyticsDeleteReviewSuccess(viewController: ProductScreenViewController) -> Void {
        Analytics.logEvent("delete_review_success",
                           parameters: [AnalyticsParameterMethod: viewController.method])
    }
    
    func sendAnalyticsChangeUserDataSuccess(viewController: UserInfoScreenViewController, userID: Int) -> Void {
        Analytics.logEvent("change_user_data_success",
                           parameters: [
                            AnalyticsParameterMethod: viewController.method,
                            "user_id": userID])
    }
    
    func sendAnalyticsFailure(failureName: String, viewController: UIViewController, errorDescription: String) -> Void {
        Analytics.logEvent(failureName,
                           parameters: [
                            AnalyticsParameterMethod: viewController.method,
                            "error_description":errorDescription])
    }
}
