//
//  AppValidationFile.swift
//  AIattorney
//
//  Created by netset on 04/07/23.
//

import Foundation

enum OnboardingValidations {
    
    // MARK: Check Validations For Login
    static func checkValidationsForLogin(_ request: LoginRequest) -> ValidationResult {
        guard !request.phoneNo.isBlank else {
            return ValidationResult(success: false, message: ValidationMessages.enterMobileNo)
        }
        guard !(request.phoneNo.count < 7) else {
            return ValidationResult(success: false, message: ValidationMessages.inValidMobileNo)
        }
        return ValidationResult(success: true, message: "")
    }
    
    // MARK: Check Validations For SignUp
    static func checkValidationsForSignUp(_ request: SignUpRequest) -> ValidationResult {
        guard !request.firstName.isBlank else {
            return ValidationResult(success: false, message: ValidationMessages.enterFirstName)
        }
        guard !request.lastName.isBlank else {
            return ValidationResult(success: false, message: ValidationMessages.enterLastName)
        }
        guard !request.phoneNo.isBlank else {
            return ValidationResult(success: false, message: ValidationMessages.enterMobileNo)
        }
        guard !(request.phoneNo.count < 7) else {
            return ValidationResult(success: false, message: ValidationMessages.inValidMobileNo)
        }
        return ValidationResult(success: true, message: "")
    }
    
    // MARK: Check Validations For OTP
    static func checkValidationForOTP(_ request: OtpRequest) -> ValidationResult {
        guard !(request.otp.isBlank) || !(request.otp.count < 4) else {
            return ValidationResult(success: false, message: ValidationMessages.enterOtp)
        }
        return ValidationResult(success: true, message: "")
    }
    
    
    // MARK: Check Validations For SignUp
    static func checkValidationsForEditProfile(_ request: EditProfileRequest) -> ValidationResult {
        guard !request.firstName.isBlank else {
            return ValidationResult(success: false, message: ValidationMessages.enterFirstName)
        }
        guard !request.lastName.isBlank else {
            return ValidationResult(success: false, message: ValidationMessages.enterLastName)
        }
        guard !request.phoneNo.isBlank else {
            return ValidationResult(success: false, message: ValidationMessages.enterMobileNo)
        }
        guard !(request.phoneNo.count < 7) else {
            return ValidationResult(success: false, message: ValidationMessages.inValidMobileNo)
        }
        return ValidationResult(success: true, message: "")
    }
    
    // MARK: Check Validation for Add Address
    static func checkValidationsForAddAddress(_ request: AddAddressRequest) -> ValidationResult {
        
        guard !request.firstName.isBlank else {
            return ValidationResult(success: false, message: ValidationMessages.enterFirstName)
        }
        guard !request.lastName.isBlank else {
            return ValidationResult(success: false, message: ValidationMessages.enterLastName)
        }
        guard !request.country.isBlank else {
            return ValidationResult(success: false, message: ValidationMessages.selectCountry)
        }
        guard !request.mobileNo.isBlank else {
            return ValidationResult(success: false, message: ValidationMessages.enterPhoneNo)
        }
        guard !(request.mobileNo.count < 7) else {
            return ValidationResult(success: false, message: ValidationMessages.inValidPhoneNo)
        }
        guard !request.address.isBlank else {
            return ValidationResult(success: false, message: ValidationMessages.enterAddress)
        }
        guard !request.apartmentNumber.isBlank else {
            return ValidationResult(success: false, message: ValidationMessages.enterApartments)
        }
        guard !request.city.isBlank else {
            return ValidationResult(success: false, message: ValidationMessages.enterCity)
        }
        return ValidationResult(success: true, message: "")
    }
}
    
enum HelpAndSupportValidation{
    static func checkValidationsForHelpAndSupport(_ request: HelpAndSupoortRequest) -> ValidationResult {
        guard !request.email.isBlank else {
            return ValidationResult(success: false, message: ValidationMessages.enterEmail)
        }
        guard request.email.isValidEmail else {
            return ValidationResult(success: false, message: ValidationMessages.inValidEmail)
        }
        guard !request.fullName.isBlank else {
            return ValidationResult(success: false, message: ValidationMessages.enterFullName)
        }
        guard !request.message.isBlank else {
            return ValidationResult(success: false, message: ValidationMessages.enterMessage)
        }
        return ValidationResult(success: true, message: "")
    }
}

enum RatingValidation {
    static func checkValidationsDriverReview(_ request: DriverReviewRequest) -> ValidationResult {
        guard !(request.rating.isZero) else {
            return ValidationResult(success: false, message: ValidationMessages.selectRating)
        }
        return ValidationResult(success: true, message: "")
    }
    
    static func checkValidationsProductReview(_ request: ProductReviewRequest) -> ValidationResult {
        guard !(request.rating.isZero) else {
            return ValidationResult(success: false, message: ValidationMessages.selectRating)
        }
        return ValidationResult(success: true, message: "")
    }
}

enum cardValidation {
    static func checkCardValidations(_ request: AddCardRequest) -> ValidationResult {
        guard !(request.cardCvv.isBlank) else {
            return ValidationResult(success: false, message: ValidationMessages.selectCardType)
        }
        guard !(request.cardNo.isBlank) else {
            return ValidationResult(success: false, message: ValidationMessages.enterCardNo)
        }
        guard !(request.cardNo.count < 14) else {
            return ValidationResult(success: false, message: ValidationMessages.enterCardNoInvalid)
        }
        guard !(request.cardUserName.isBlank) else {
            return ValidationResult(success: false, message: ValidationMessages.enterCardUser)
        }
        guard !(request.cardExpDate.isBlank) else {
            return ValidationResult(success: false, message: ValidationMessages.enterCardExpire)
        }
        return ValidationResult(success: true, message: "")
    }
}
