//
//  ApisUrlListFile.swift
//  AIattorney
//
//  Created by netset on 04/07/23.
//

import Foundation

// MARK: - Server Link
struct ServerLink {
    
    // Base url's
    static let baseUrlApi = "https://www.netset.com"
    //Socket Url's
    static let webSocketUrl = "https://www.netset.com"
    //Image bucket s3 url's
    static let imageUploadBaseUrl = "https://www.netset.com"
}

// MARK: - Api's
struct ApiUrl {
    static let signUp = ServerLink.baseUrlApi + "sign-up"
    static let signIn = ServerLink.baseUrlApi + "login"
    static let signInOTPVerify = ServerLink.baseUrlApi + "login"
    static let signUpOTPVerify = ServerLink.baseUrlApi + "sign-up/otp/verify"
    static let getProfileDetails = ServerLink.baseUrlApi + "user/who/am/i"
    static let uploadImage = ServerLink.baseUrlApi + "user/profile"
    static let updateProfile = ServerLink.baseUrlApi + "user/update"
    static let recetlyListed = ServerLink.baseUrlApi + "product/cultivator/filter"
    static let userUpdatePhone = ServerLink.baseUrlApi + "user/update/phone"
    static let categeory = ServerLink.baseUrlApi + "category"
    static let filterCategeory = ServerLink.baseUrlApi + "category/filter"
    static let productDetail = ServerLink.baseUrlApi + "product/cultivator"
    static let productDetailImages = ServerLink.baseUrlApi + "product/file/list"
    static let addAddress = ServerLink.baseUrlApi + "address"
    static let getAddressData = ServerLink.baseUrlApi + "address/user/my"
    static let deleteAddress = ServerLink.baseUrlApi + "address"
    static let quantityStock = ServerLink.baseUrlApi + "product-stock/cultivator"
    static let addToCart = ServerLink.baseUrlApi + "cart"
    static let getCartdata = ServerLink.baseUrlApi + "cart"
    static let increaseItemCount = ServerLink.baseUrlApi + "cart"
    static let selectedPrimaryAddress = ServerLink.baseUrlApi + "address/primary"
    static let helpAndSupport = ServerLink.baseUrlApi + "contact-us"
    static let driverReviews = ServerLink.baseUrlApi + "driver-review"
    static let productReviews = ServerLink.baseUrlApi + "product/review"
    static let addCardDetails = ServerLink.baseUrlApi + "payu/cards"
    static let getCardList = ServerLink.baseUrlApi + "stripe/cards"
    static let deleteCard = ServerLink.baseUrlApi + "payu/cards"
    static let getMyPrimaryCard = ServerLink.baseUrlApi + "payu/cards/primary"
    static let selectedPrimaryCard = ServerLink.baseUrlApi + "payu/cards/primary"
    static let getMyPrimaryAddress = ServerLink.baseUrlApi + "address/user/my/primary"
    static let orderPlace = ServerLink.baseUrlApi + "checkout"
    static let shoppingCartCount = ServerLink.baseUrlApi + "cart/count"
    static let allCultivator = ServerLink.baseUrlApi + "user/filter"
    static let cultivatorProducts = ServerLink.baseUrlApi + "product/cultivator/filter"
    static let orderHistory = ServerLink.baseUrlApi + "order/filter"
    static let orderDetails = ServerLink.baseUrlApi + "order"
    static let orderReview =  ServerLink.baseUrlApi + "order/review"
    static let estimatedTime = ServerLink.baseUrlApi + "cart/eta"
    static let orderCancel = ServerLink.baseUrlApi + "order/cancel"
    static let notifications = ServerLink.baseUrlApi + "notifications"
    static let updateDeviceToken = ServerLink.baseUrlApi + "user/status/true"
    static let searchHistory = ServerLink.baseUrlApi + "search-history"
    static let selectLanguage = ServerLink.baseUrlApi + "user/language"
    static let deleteAccount = ServerLink.baseUrlApi + "user/delete"
    static let cultivatorStatus = ServerLink.baseUrlApi + "cultivator/online"
    static let virtualCredits = ServerLink.baseUrlApi + "virtual-credits"
}

// MARK: - App Keys

struct AppKeys {
    
    enum GoogleInfo {
        static let googleKey = "xxxx"
    }
    
    // MARK: - Stripe Payment Key
    enum stripeApikey {
        static let stripePublishKey = "xxxx"
    }
    
}
