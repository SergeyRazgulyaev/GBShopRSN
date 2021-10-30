//
//  AnalyticsSendable.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 28.03.2021.
//

import UIKit
import FirebaseAnalytics

protocol AnalyticsSendable {
    func sendAnalyticsSignUpSuccess(assignedUserId: Int,
                                    signedUpUserLogin: String,
                                    signedUpUserName: String,
                                    signedUpUserLastName: String,
                                    signedUpEmail: String,
                                    signedUpGender: String,
                                    signedUpCreditCard: String,
                                    signedUpBio: String,
                                    userMessage: String) -> Void
    
    func sendAnalyticsLogInSuccess(userID: Int,
                                   userName: String,
                                   userLastname: String) -> Void
    
    func sendAnalyticsLogOutSuccess(userID: Int) -> Void

    func sendAnalyticsOpenProductListSuccess(productListCount: Int) -> Void
    
    func sendAnalyticsOpenProductSuccess(productID: Int,
                                         productName: String,
                                         productPrice: Int,
                                         productDescription: String,
                                         quantityInBasket: Int) -> Void
    
    func sendAnalyticsGetBasketSuccess(userID: Int,
                                       amount: Int,
                                       typeOfGoodsCount: Int) -> Void
   
    func sendAnalyticsAddToBasketSuccess(addedProductID: Int,
                                         updatedQuantityInBasket: Int) -> Void
    
    func sendAnalyticsDeleteFromBasketSuccess(deletedProductID: Int,
                                              deletedProductQuantityInBasket: Int) -> Void
    
    func sendAnalyticsPayBasketSuccess(userID: Int,
                                       payAmount: Int,
                                       accountBalance: Int) -> Void
    
    func sendAnalyticsGetReviewsSuccess(reviewsCount: Int) -> Void
    
    func sendAnalyticsAddReviewSuccess(userMessage: String) -> Void
    
    func sendAnalyticsDeleteReviewSuccess(deletedReviewID: Int) -> Void
    
    func sendAnalyticsChangeUserDataSuccess(userID: Int) -> Void
    
    func sendAnalyticsFailure(failureName: String,
                              errorDescription: String) -> Void
}

extension AnalyticsSendable {
    func sendAnalyticsSignUpSuccess(assignedUserId: Int,
                                    signedUpUserLogin: String,
                                    signedUpUserName: String,
                                    signedUpUserLastName: String,
                                    signedUpEmail: String,
                                    signedUpGender: String,
                                    signedUpCreditCard: String,
                                    signedUpBio: String,
                                    userMessage: String) -> Void {
        Analytics.logEvent("sign_up_success",
                           parameters: [
                            "assigned_user_id": assignedUserId as NSObject,
                            "signedUpUserLogin": signedUpUserLogin as NSObject,
                            "signed_up_user_name": signedUpUserName as NSObject,
                            "signed_up_user_last_name": signedUpUserLastName as NSObject,
                            "signed_up_email": signedUpEmail as NSObject,
                            "signed_up_gender": signedUpGender as NSObject,
                            "signed_up_credit_card": signedUpCreditCard as NSObject,
                            "signed_up_bio": signedUpBio as NSObject,
                            "user_message": userMessage as NSObject])
    }
    
    func sendAnalyticsLogInSuccess(userID: Int,
                                   userName: String,
                                   userLastname: String) -> Void {
        Analytics.logEvent("log_in_success",
                           parameters: [
                            "logged_in_user_id": userID as NSObject,
                            "logged_in_user_name": userName as NSObject,
                            "logged_in_user_lastname": userLastname as NSObject])
    }
    
    func sendAnalyticsLogOutSuccess(userID: Int) -> Void {
        Analytics.logEvent("log_out_success",
                           parameters: ["user_id": userID as NSObject])
    }
    
    func sendAnalyticsOpenProductListSuccess(productListCount: Int) -> Void {
        Analytics.logEvent("open_product_list_success",
                           parameters: ["product_list_count": productListCount as NSObject])
    }
    
    func sendAnalyticsOpenProductSuccess(productID: Int,
                                         productName: String,
                                         productPrice: Int,
                                         productDescription: String,
                                         quantityInBasket: Int) -> Void {
        Analytics.logEvent("open_product_success",
                           parameters: [
                            "product_id": productID as NSObject,
                            "product_name": productName as NSObject,
                            "product_price": productPrice as NSObject,
                            "product_description": productDescription as NSObject,
                            "quantity_in_basket": quantityInBasket as NSObject])
    }
    
    func sendAnalyticsGetBasketSuccess(userID: Int,
                                       amount: Int,
                                       typeOfGoodsCount: Int) -> Void {
        Analytics.logEvent("get_basket_success",
                           parameters: [
                            "user_id": userID as NSObject,
                            "amount": amount as NSObject,
                            "type_of_goods_count": typeOfGoodsCount as NSObject])
    }
    
    func sendAnalyticsAddToBasketSuccess(addedProductID: Int,
                                         updatedQuantityInBasket: Int) -> Void {
        Analytics.logEvent("add_to_basket_success",
                           parameters: [
                            "added_product_id": addedProductID as NSObject,
                            "updated_quantity_in_basket": updatedQuantityInBasket as NSObject])
    }
    
    func sendAnalyticsDeleteFromBasketSuccess(deletedProductID: Int,
                                              deletedProductQuantityInBasket: Int) -> Void {
        Analytics.logEvent("delete_from_basket_success",
                           parameters: [
                            "deleted_product_id": deletedProductID as NSObject,
                            "deleted_product_quantity_in_basket": deletedProductQuantityInBasket as NSObject])
    }
    
    func sendAnalyticsPayBasketSuccess(userID: Int,
                                       payAmount: Int,
                                       accountBalance: Int) -> Void {
        Analytics.logEvent("pay_basket_success",
                           parameters: [
                            "user_id": userID as NSObject,
                            "pay_amount": payAmount as NSObject,
                            "account_balance": accountBalance as NSObject])
    }
    
    func sendAnalyticsGetReviewsSuccess(reviewsCount: Int) -> Void {
        Analytics.logEvent("get_reviews_success",
                           parameters: ["reviews_count": reviewsCount as NSObject])
    }
    
    func sendAnalyticsAddReviewSuccess(userMessage: String) -> Void {
        Analytics.logEvent("add_review_success",
                           parameters: ["user_message": userMessage as NSObject])
    }
    
    func sendAnalyticsDeleteReviewSuccess(deletedReviewID: Int) -> Void {
        Analytics.logEvent("delete_review_success",
                           parameters: ["deleted_review_id": deletedReviewID as NSObject])
    }
    
    func sendAnalyticsChangeUserDataSuccess(userID: Int) -> Void {
        Analytics.logEvent("change_user_data_success",
                           parameters: ["user_id": userID as NSObject])
    }
    
    func sendAnalyticsFailure(failureName: String,
                              errorDescription: String) -> Void {
        Analytics.logEvent(failureName,
                           parameters: ["error_description": errorDescription as NSObject])
    }
}
