//
//  EditProfileVCExt.swift
//  Semilla
//
//  Created by Netset on 05/02/24.
//

import Foundation


extension EditProfileVC: DelegatesEditProfile {
    
    // MARK: - Click to Back
    func goToBack() {
        self.popViewController(true)
    }
    
    // MARK: - Click to Submit Edited Profile Details
    func gotoSubmit(_ request: EditProfileRequest) {
        objViewModel.editProfileApiMethod(request) {
            if (loginUserDetail?.phone ?? "") == "\(request.countryCode)\(request.phoneNo.removeSpaceAndHyphen())" {
                self.popViewController(true)
                Alerts.shared.showAlert(title: AlertMessages.appName, message: ValidationMessages.profileUpdated)
            } else {
                let vc = getStoryboard(.main).instantiateViewController(withIdentifier: ViewControllers.otpVerificationVC) as! OTPVerificationVC
                vc.objOTPVerificationVM.isComingFromLogin = ScreenTypes.myEditProfile
                vc.objOTPVerificationVM.otpSentOnNumber = "\(request.phoneNo)"
                vc.objOTPVerificationVM.countryCode = "\(request.countryCode)"
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    // MARK: - Click Button to click Image from camera
    func goTocamera() {
        let vc = getStoryboard(.checkout).instantiateViewController(withIdentifier: ViewControllers.changeProfilePictureVC) as! ChangeProfilePictureVC
        vc.callBackToOpenCamera = {
            self.objImagePickerManager?.openCamera(image: true, video: false)
        }
        vc.callBackToOpenGallery = {
            self.objImagePickerManager?.openGallary(image: true, video: false)
        }
        self.present(vc, animated: true)
    }
}
