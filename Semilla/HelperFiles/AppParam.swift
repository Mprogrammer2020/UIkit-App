//
//  AppParam.swift
//  AIattorney
//
//  Created by netset on 04/07/23.
//

import Foundation

struct AppParam {
    
    enum SignIn {
        static let phone = "phone"
        static let role = "role"
        static let countryCode = "countryCode"
    }
    
    enum SignUp {
        static let firstName = "firstName"
        static let lastName =  "lastName"
        static let countryCode = "countryCode"
        static let phone = "phone"
        static let role =  "role"
    }
    
    
    enum OtpVerify {
        static let firstName = "firstName"
        static let lastName =  "lastName"
        static let countryCode = "countryCode"
        static let phone = "phone"
        static let otp = "otp"
        static let role = "role"
    }
    
    enum ProfileImage {
        static let file = "file"
        static let type = "type"
    }
    
    enum UpdateProfileDetails {
        static let file = "file"
        static let profile = "profile"
        static let firstName = "firstName"
        static let lastName =  "lastName"
        static let countryCode = "countryCode"
        static let phone = "phone"
    }
    
    enum HomeRecentlyListed {
        static let page = "page"
        static let size = "size"
        static let name = "name"
        static let latitude = "latitude"
        static let longitude = "longitude"
        static let categoryId = "categoryId"
    }
    
    enum cultivatorList {
        static let page = "page"
        static let size = "size"
        static let userId = "userId"
        static let search = "search"
        static let rating = "rating"
        static let distance = "distance"
        static let latitude = "latitude"
        static let longitude = "longitude"
        static let categoryIds = "categoryIds"
    }
    
    enum AddAddress {
        static let firstName = "firstName"
        static let lastName = "lastName"
        static let country = "country"
        static let phone = "phone"
        static let address = "address"
        static let zipCode = "zipCode"
        static let apartmentNumber = "apartmentNumber"
        static let city = "city"
        static let street = "street"
        static let type = "type"
        static let id = "id"
        static let primaryA = "primaryA"
        static let longitude = "longitude"
        static let latitude = "latitude"
        static let countryCode = "countryCode"
    }
    
    enum ShoppingCartItem {
        static let count = "count"
    }
    
    enum HelpAndSupport {
        static let name = "name"
        static let email =  "email"
        static let message = "message"
    }
    
    enum DriverRatingReview {
        static let id = "id"
        static let rating = "rating"
        static let description = "description"
    }
    
    
    enum Checkout {
        static let cultivatorId = "cultivatorId"
        static let itemTotal = "itemTotal"
        static let deliveryFee = "deliveryFee"
        static let serviceFee = "serviceFee"
        static let cartTotal = "cartTotal"
        static let addressId = "addressId"
        static let cardToken = "cardToken"
        static let id = "id"
        static let creditsUsed = "creditsUsed"
    }
    
    enum AddCard {
        static let payerName = "payerName"
        static let cardNumber = "cardNumber"
        static let expirationDate = "expirationDate"
        static let paymentMethod = "paymentMethod"
    }
}
