//
//  SignUpVM.swift
//  Semilla
//
//  Created by Netset on 29/11/23.
//

import Foundation

class SignUpVM {
    
    func signUpApiMethod(_ request: SignUpRequest, completion:@escaping() -> Void) {
        let result = performValidations(request)
        if !result.success {
            Alerts.shared.showAlert(title: AlertMessages.appName, message:  result.message ?? "")
        } else {
            let param = [
                AppParam.SignUp.firstName: "\(request.firstName)",
                AppParam.SignUp.lastName: "\(request.lastName)",
                AppParam.SignUp.phone:"\(request.countryCode)\(request.phoneNo.removeSpaceAndHyphen())",
                AppParam.SignUp.countryCode:"\(request.countryCode)",
                AppParam.SignUp.role:"\(AppRoles.user)"
            ]
            WebServices.shared.postData(ApiUrl.signUp, params: param, showIndicator: true, methodType: .post) { response in
                if response.isSuccess {
                    completion()
                } else {
                    Alerts.shared.showAlert(title: AlertMessages.appName, message: response.message)
                }
            }
        }
    }
    
    
    // MARK: Perform Validations Method
    private func performValidations(_ request: SignUpRequest) -> ValidationResult {
        return OnboardingValidations.checkValidationsForSignUp(request)
    }

}
