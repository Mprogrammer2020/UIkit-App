//
//  HelpAndSupportVM.swift
//  Semilla
//
//  Created by Netset on 23/02/24.
//

import Foundation

class HelpAndSupportVM {
    
    var message:String?
    
    func contactUsApiMethod(_ request: HelpAndSupoortRequest, completion:@escaping() -> Void) {
        let result = performValidations(request)
        if !result.success {
            Alerts.shared.showAlert(title: AlertMessages.appName, message:  result.message ?? "")
        } else {
            let param = [
                AppParam.HelpAndSupport.name    : "\(request.fullName)",
                AppParam.HelpAndSupport.email   : "\(request.email)",
                AppParam.HelpAndSupport.message : "\(request.message)"
            ]

            WebServices.shared.postData(ApiUrl.helpAndSupport, params: param, showIndicator: true, methodType: .post) { response in
                if response.isSuccess {
                    let apiData = Constants.shared.jsonDecoder.decode(model: ProfileDetailsModel.self, data: response.data)
                    if apiData?.data?.user != nil {
                        loginUserDetail = apiData?.data?.user
                        self.message = apiData?.message ?? ""
                    }
                    completion()
                } else {
                    Alerts.shared.showAlert(title: AlertMessages.appName, message: response.message)
                }

            }
        }
    }
    
    
    // MARK: Perform Validations Method
    private func performValidations(_ request: HelpAndSupoortRequest) -> ValidationResult {
        return HelpAndSupportValidation.checkValidationsForHelpAndSupport(request)
    }
    
}
