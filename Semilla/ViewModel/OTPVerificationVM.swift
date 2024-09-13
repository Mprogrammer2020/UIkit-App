//
//  OTPVerificationVM.swift
//  Semilla
//
//  Created by Netset on 29/11/23.
//

import Foundation

class OTPVerificationVM {
    
    // MARK: Variable Declaration
    var otpSentOnNumber = String()
    var countryCode = String()
    var firstName = String()
    var lastName = String()
    var isComingFromLogin = String()
    var timer = Timer()
    
    func otpApiMethodSignupVerify(_ request: OtpRequest, completion:@escaping() -> Void) {
        let result = performValidations(request)
        if !result.success {
            Alerts.shared.showAlert(title: AlertMessages.appName, message:  result.message ?? "")
        } else {
            let param = [
                AppParam.OtpVerify.countryCode:"\(request.countryCode)",
                AppParam.OtpVerify.otp:"\(request.otp)",
                AppParam.OtpVerify.phone:"\(request.countryCode)\(request.phone.removeSpaceAndHyphen())",
                AppParam.OtpVerify.firstName:"\(firstName)",
                AppParam.OtpVerify.lastName:"\(lastName)",
                AppParam.SignUp.role:"\(AppRoles.user)"
            ]
            WebServices.shared.postData(ApiUrl.signUpOTPVerify, params: param, showIndicator: true, methodType: .post) { response in
                if response.isSuccess {
                    let apiData = Constants.shared.jsonDecoder.decode(model: ProfileDetailsModel.self, data: response.data)
                    if let dataDict = response.JSON["data"] as? NSDictionary {
                        accessTokenSaved = dataDict["token"] as? String ?? ""
                    }
                    loginUserDetail = apiData?.data?.user
                    isShowNotificationCount = (apiData?.data?.user?.notifyCount ?? 0) > 0
                    payuCardId = apiData?.data?.user?.stripePrimaryCardId ?? ""
                    completion()
                } else {
                    Alerts.shared.showAlert(title: AlertMessages.appName, message: response.message)
                }
            }
        }
    }
    
    func otpApiMethodLoginVerify(_ request: OtpRequest, completion:@escaping() -> Void) {
        let result = performValidations(request)
        if !result.success {
            Alerts.shared.showAlert(title: AlertMessages.appName, message:  result.message ?? "")
        } else {
            let param = [
                AppParam.OtpVerify.countryCode: "\(request.countryCode)",
                AppParam.OtpVerify.otp: "\(request.otp)",
                AppParam.OtpVerify.phone: "\(request.countryCode)\(request.phone.removeSpaceAndHyphen())",
                AppParam.SignUp.role:"\(AppRoles.user)"
            ]
            WebServices.shared.postData(ApiUrl.signInOTPVerify, params: param, showIndicator: true, methodType: .post) { response in
                if response.isSuccess {
                    let apiData = Constants.shared.jsonDecoder.decode(model: ProfileDetailsModel.self, data: response.data)
                    if let dataDict = response.JSON["data"] as? NSDictionary {
                        accessTokenSaved = dataDict["token"] as? String ?? ""
                    }
                    loginUserDetail = apiData?.data?.user
                    payuCardId = apiData?.data?.user?.stripePrimaryCardId ?? ""
                    isShowNotificationCount = (apiData?.data?.user?.notifyCount ?? 0) > 0
                    completion()
                } else {
                    Alerts.shared.showAlert(title: AlertMessages.appName, message: response.message)
                }
            }
        }
    }
    
    
    func otpResendApiMethod(_ request: OtpRequest, completion:@escaping() -> Void) {
        if self.isComingFromLogin == ScreenTypes.login {
            let param = [
                AppParam.OtpVerify.countryCode: "\(request.countryCode)",
                AppParam.OtpVerify.phone: "\(request.countryCode)\(request.phone.removeSpaceAndHyphen())",
                AppParam.SignUp.role:"\(AppRoles.user)"
            ]
            WebServices.shared.postData(ApiUrl.signInOTPVerify, params: param, showIndicator: true, methodType: .post) { response in
                if response.isSuccess {
                    Alerts.shared.showAlert(title: AlertMessages.appName, message: ValidationMessages.oTPReSentSuccessfully)
                    completion()
                } else {
                    Alerts.shared.showAlert(title: AlertMessages.appName, message: response.message)
                }
            }
        } else if self.isComingFromLogin == ScreenTypes.signUp {
            let param = [
                AppParam.OtpVerify.countryCode: "\(request.countryCode)",
                AppParam.OtpVerify.phone: "\(request.countryCode)\(request.phone.removeSpaceAndHyphen())",
                AppParam.SignUp.role:"\(AppRoles.user)"
            ]
            WebServices.shared.postData(ApiUrl.signUpOTPVerify, params: param, showIndicator: true, methodType: .post) { response in
                if response.isSuccess {
                    Alerts.shared.showAlert(title: AlertMessages.appName, message: ValidationMessages.oTPReSentSuccessfully)
                    completion()
                } else {
                    Alerts.shared.showAlert(title: AlertMessages.appName, message: response.message)
                }
            }
        } else {
            let param = [
                AppParam.OtpVerify.countryCode: "\(request.countryCode)",
                AppParam.OtpVerify.phone: "\(request.countryCode)\(request.phone.removeSpaceAndHyphen())",
                AppParam.SignUp.role:"\(AppRoles.user)"
            ]
            WebServices.shared.postData(ApiUrl.userUpdatePhone, params: param, showIndicator: true, methodType: .post) { response in
                if response.isSuccess {
                    Alerts.shared.showAlert(title: AlertMessages.appName, message: ValidationMessages.oTPReSentSuccessfully)
                    completion()
                } else {
                    Alerts.shared.showAlert(title: AlertMessages.appName, message: response.message)
                }
            }
        }
    }
    
    func otpApiMethodPhoneNumberChange(_ request: OtpRequest, completion:@escaping() -> Void) {
        let param = [
            AppParam.OtpVerify.countryCode: "\(request.countryCode)",
            AppParam.OtpVerify.otp: "\(request.otp)",
            AppParam.OtpVerify.phone: "\(request.countryCode)\(request.phone.removeSpaceAndHyphen())",
            AppParam.SignUp.role:"\(AppRoles.user)"
        ]
        WebServices.shared.postData(ApiUrl.userUpdatePhone, params: param, showIndicator: true, methodType: .post) { response in
            if response.isSuccess {
                if let dataDict = response.JSON["data"] as? NSDictionary {
                    accessTokenSaved = dataDict["token"] as? String ?? ""
                }
                let apiData = Constants.shared.jsonDecoder.decode(model: ProfileDetailsModel.self, data: response.data)
                if apiData?.data?.user != nil {
                    loginUserDetail = apiData?.data?.user
                    payuCardId = apiData?.data?.user?.stripePrimaryCardId ?? ""
                }
                completion()
            } else {
                Alerts.shared.showAlert(title: AlertMessages.appName, message: response.message)
            }
        }
    }
    
    // MARK: Perform Validations Method
    private func performValidations(_ request: OtpRequest) -> ValidationResult {
        return OnboardingValidations.checkValidationForOTP(request)
    }
    
    
}
