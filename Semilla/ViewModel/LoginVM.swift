//
//  LoginVM.swift
//  AIattorney
//
//  Created by netset on 07/07/23.
//

import Foundation

class LoginVM {
    
    // MARK: Login Api Method
    func loginApiMethod(_ request: LoginRequest,completion:@escaping() -> Void) {
        let result = performValidations(request)
        if !result.success {
            Alerts.shared.showAlert(title: AlertMessages.appName, message:  result.message ?? "")
        } else {
            let param = [
                AppParam.SignIn.phone:"\(request.countryCode)\(request.phoneNo.removeSpaceAndHyphen())",
                AppParam.SignIn.countryCode:"\(request.countryCode)",
                AppParam.SignIn.role:"\(AppRoles.user)"
            ]
            WebServices.shared.postData(ApiUrl.signIn, params: param, showIndicator: true, methodType: .post) { (response) in
                if response.isSuccess {
                    completion()
                } else {
                    Alerts.shared.showAlert(title: AlertMessages.appName, message: response.message)
                }
            }
        }
    }
    
    // MARK: Perform Validations Method
    private func performValidations(_ request: LoginRequest) -> ValidationResult {
        return OnboardingValidations.checkValidationsForLogin(request)
    }

}
