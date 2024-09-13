//
//  MyProfileVM.swift
//  Semilla
//
//  Created by Baljinder [iMac] on 07/02/24.
//

import Foundation
import UIKit

class MyProfileVM {
    
    //var objProfileUserDetailsData: UserDataDetails?
    
    //MARK: Get Profile Details Api Method
//    func getProfileDetailsApiMethod(_ completion:@escaping() -> Void) {
//        WebServices.shared.getData(ApiUrl.getProfileDetails, showIndicator: true) { response in
//            if response.isSuccess {
//                let apiData = Constants.shared.jsonDecoder.decode(model: ProfileDetailsModel.self, data: response.data)!
//                self.objProfileUserDetailsData = apiData.data
//                completion()
//            } else {
//                Alerts.shared.showAlert(title: AlertMessages.appName, message: response.message)
//            }
//        }
//    }
    
    //MARK: Upload Profile picture Api Method
    func uploadProfilePictureApiMethod(_ image: UIImage, Completion:@escaping() -> Void) {
        let param = [
            AppParam.ProfileImage.type: "image"
        ] as [String:AnyObject]
        let paramImage = [
            AppParam.ProfileImage.file: image
        ]
        WebServices.shared.uploadMediaFiles(ApiUrl.uploadImage, params: param, docParam: [:], paramDoc: [:], imageParam: paramImage, videoParam: [:], showIndicator: true, methodType: .put) { response in
            if response.isSuccess {
                let apiData = Constants.shared.jsonDecoder.decode(model: ProfileDetailsModel.self, data: response.data)
                if apiData?.data?.user != nil {
                    loginUserDetail = apiData?.data?.user
                }
                Completion()
            } else {
                Alerts.shared.showAlert(title: AlertMessages.appName, message: response.message)
            }
        }
    }
    
    //MARK: - Delete Account Api Method
    func deleteAccountApiMethod(_ completion: @escaping() -> Void) {
        WebServices.shared.postData("\(ApiUrl.deleteAccount)", params: [:], showIndicator: true, methodType: .put) { response in
            if response.isSuccess {
                Alerts.shared.showAlert(title: AlertMessages.appName, message: response.message)
                completion()
            } else {
                Alerts.shared.showAlert(title: AlertMessages.appName, message: response.message)
            }
        }
    }
    
}
