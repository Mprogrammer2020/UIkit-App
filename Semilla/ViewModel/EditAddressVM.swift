//
//  EditAddressVM.swift
//  Semilla
//
//  Created by Netset on 21/02/24.
//

import Foundation

class EditAddressVM {
    
    var addressType = String()
    var objAddressData: MyAddressesList?
    var totalAddressCount = Int()
    
    func addAddressApiMethod(_ request:AddAddressRequest,completion:@escaping(MyAddressesList?) -> Void) {
        let result = performValidations(request)
        if !result.success {
            Alerts.shared.showAlert(title: AlertMessages.appName, message:  result.message ?? "")
        } else {
            var param = [
                AppParam.AddAddress.firstName: "\(request.firstName)",
                AppParam.AddAddress.lastName: "\(request.lastName)",
                AppParam.AddAddress.country: "\(request.country)",
                AppParam.AddAddress.phone: "\(request.countryCode)\(request.mobileNo)",
                AppParam.AddAddress.countryCode: "\(request.countryCode)",
                AppParam.AddAddress.address: "\(request.address)",
                AppParam.AddAddress.apartmentNumber: "\(request.apartmentNumber)",
                AppParam.AddAddress.city: "\(request.city)",
                AppParam.AddAddress.street: "\(request.streetAddr)",
                AppParam.AddAddress.type: "\(request.type)",
                AppParam.AddAddress.latitude: "\(request.latitude)",
                AppParam.AddAddress.longitude: "\(request.longitude)"
            ]
            if (objAddressData?.id ?? 0) != 0 {
                param [AppParam.AddAddress.id] = "\(objAddressData?.id ?? 0)"
                param [AppParam.AddAddress.primaryA] = "\(objAddressData?.primaryA ?? false)"
            }
            WebServices.shared.postData(ApiUrl.addAddress, params: param, showIndicator: true, methodType: .post) { response in
                if response.isSuccess {
                    let apiData = Constants.shared.jsonDecoder.decode(model: MyAddressesModel.self, data: response.data)
                    completion(apiData?.data?.resource)
                } else {
                    Alerts.shared.showAlert(title: AlertMessages.appName, message: response.message)
                }
            }
        }
    }
    
    // MARK: Perform Validations Method
    private func performValidations(_ request: AddAddressRequest) -> ValidationResult {
        return OnboardingValidations.checkValidationsForAddAddress(request)
    }
    
}
