//
//  EditProfileVM.swift
//  Semilla
//
//  Created by Baljinder [iMac] on 08/02/24.
//

import Foundation
import UIKit


class EditProfileVM {
    
    var selectImage:UIImage?
    
    func editProfileApiMethod(_ request: EditProfileRequest,completion:@escaping() -> Void) {
        let result = performValidations(request)
        if !result.success {
            Alerts.shared.showAlert(title: AlertMessages.appName, message:  result.message ?? "")
        } else {
            let profileDict = [
                AppParam.UpdateProfileDetails.firstName:"\(request.firstName)",
                AppParam.UpdateProfileDetails.lastName:"\(request.lastName)",
                AppParam.UpdateProfileDetails.phone:"\(request.countryCode)\(request.phoneNo.removeSpaceAndHyphen())",
                AppParam.UpdateProfileDetails.countryCode:"\(request.countryCode)"
            ]
            let jsonStr = CommonMethod.shared.convertDictionaryToJSON(profileDict)
            var paramImage = [String:UIImage]()
            if selectImage != nil {
                paramImage[AppParam.UpdateProfileDetails.file] = selectImage!
            } else {
                paramImage = [:]
            }
            let param = [
                AppParam.UpdateProfileDetails.profile:"\(jsonStr ?? "")"
            ] as [String:AnyObject]
            
            WebServices.shared.uploadMediaFiles(ApiUrl.updateProfile, params: param, docParam: [:], paramDoc: [:], imageParam: paramImage, videoParam: [:], showIndicator: true, methodType: .put) { response in
                if response.isSuccess {
                    let apiData = Constants.shared.jsonDecoder.decode(model: ProfileDetailsModel.self, data: response.data)
                    if apiData?.data?.user != nil {
                        loginUserDetail = apiData?.data?.user
                    }
                    completion()
                } else {
                    Alerts.shared.showAlert(title: AlertMessages.appName, message: response.message)
                }
            }
        }
    }
    
    // MARK: Perform Validations Method
    private func performValidations(_ request: EditProfileRequest) -> ValidationResult {
        return OnboardingValidations.checkValidationsForEditProfile(request)
    }
}
