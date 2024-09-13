//
//  RequestModel.swift
//  AIattorney
//
//  Created by netset on 04/07/23.
//

import Foundation

struct LoginRequest {
    var phoneNo = String()
    var countryCode = String()
}

struct forgotRequest {
    var email = String()
}

struct SignUpRequest {
    var firstName = String(),
    lastName = String(),
    phoneNo = String(),
    countryCode = String()
}

struct  OtpRequest {
    var countryCode = String()
    var otp = String()
    var phone = String()
}
    
struct EditProfileRequest {
    var firstName = String(),
    lastName = String(),
    phoneNo = String(),
    countryCode = String()
}

struct AddCardRequest {
    var cardNo = String(),
    cardUserName = String(),
    cardCvv = String(),
    cardExpDate = String(),
    cardYear = Int(),
    cardMonth = Int(),
    cardType = String()
    
}


struct AddAddressRequest {
    var firstName = String(),
    lastName = String(),
    country = String(),
    countryCode = String(),
    mobileNo = String(),
    address = String(),
    zipCode = String(),
    apartmentNumber = String(),
    city = String(),
    type = String(),
    streetAddr = String(),
    latitude = Double(),
    longitude = Double()
}

struct HelpAndSupoortRequest {
    var email = String(),
    fullName = String(),
    message = String()
}


struct DriverReviewRequest {
    var rating = Float(),
    message = String()
}

struct ProductReviewRequest {
    var rating = Float(),
    message = String()
}
