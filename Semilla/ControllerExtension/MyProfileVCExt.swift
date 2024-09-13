//
//  MyProfileVCExt.swift
//  Semilla
//
//  Created by Netset on 06/12/23.
//

import Foundation
import UIKit
import SDWebImage
import CountryPickerView

extension MyProfileVC: DelegatesMyProfile {
    
    
    // MARK: - call Profile Details Api Method
    func callApiToGetUserDetails() {
        //objMyProfileVM.getProfileDetailsApiMethod {
        let detail = loginUserDetail
        let objCountryPicker = CountryPickerView()
        self.vwProperties.lblUserName.text = "\(detail?.firstName ?? "") \(detail?.lastName ?? "")"
        let phone = (detail?.phone?.replacingOccurrences(of: detail?.countryCode ?? "", with: "") ?? "")
        let country = objCountryPicker.getCountryByPhoneCode(detail?.countryCode ?? "")
        let phoneCode = country?.code ?? ""
        let formatPhoneNo = phone.setFormatPhoneNo(phoneCode)
        self.vwProperties.lblUserMobileNumber.text = "\(detail?.countryCode ?? "") \(formatPhoneNo)"
        self.vwProperties.imgVwUserProfile.setImageOnImageViewServer("\(detail?.imagePath ?? "")", placeholder: UIImage(named: "ic_placeholder")!)
        // }
    }
    
    // MARK: - Call Api Upload Profile Image
    func callApiImageUpload(_ image:UIImage) {
        objMyProfileVM.uploadProfilePictureApiMethod(image) {
            self.vwProperties.imgVwUserProfile.image = self.selectedImage
        }
    }
    
    
    // MARK: - Button Change Profile Pic Camera Clicked
    func gotoChangeProfilePicture() {
        let vc = getStoryboard(.checkout).instantiateViewController(withIdentifier: ViewControllers.changeProfilePictureVC) as! ChangeProfilePictureVC
        vc.callBackToOpenCamera = {
            self.objImagePickerManager?.openCamera(image: true, video: false)
        }
        vc.callBackToOpenGallery = {
            self.objImagePickerManager?.openGallary(image: true, video: false)
        }
        self.present(vc, animated: true)
    }
    
    // MARK: - Button Credit Card Clicked
    func gotoCreditCards() {
        self.pushToViewController(storyBoard: .home, Identifier: ViewControllers.creditCardsVC, animated: true)
    }
    
    // MARK: - Button Help Support Clicked
    func gotoHelpAndSupport() {
        self.pushToViewController(storyBoard: .home, Identifier: ViewControllers.helpAndSupportVC, animated: true)
    }
    
    // MARK: - Button Notification Clicked
    func gotoNotification() {
        self.pushToViewController(storyBoard: .home, Identifier: ViewControllers.notificationsVC, animated: true)
    }
    
    // MARK: - Button Back Clicked
    func gotoBack() {
        self.popViewController(true)
    }
    
    // MARK: - Button About Me Clicked
    func gotoAboutUs() {
        let vc = getStoryboard(.home).instantiateViewController(withIdentifier: ViewControllers.aboutUsVC) as! AboutUsVC
        vc.screenTitle = DisplayNames.aboutUs
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Button Order History Clicked
    func gotoOrderHistory() {
        self.pushToViewController(storyBoard: .checkout, Identifier: ViewControllers.orderHistoryVC, animated: true)
    }
    
    // MARK: - Button SignOut Clicked
    func signOut() {
        let vc = getStoryboard(.checkout).instantiateViewController(withIdentifier: ViewControllers.signOutVC) as! SignOutVC
        vc.callBackToGoRootView = {
            RootControllerProxy.shared.rootWithoutDrawer(ViewControllers.loginVC, storyboard: .main)
        }
        self.present(vc, animated: false)
    }
    
    // MARK: - Button My Adress Clicked
    func myAddress() {
        let vc = getStoryboard(.home).instantiateViewController(withIdentifier: ViewControllers.myAddressesVC) as! MyAddressesVC
        vc.objMyAddressesVM.isComingFrom = ScreenTypeMyAddress.isComingFromMyProfile
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Button Edit Address Clicked
    func editProfile() {
        let vc = getStoryboard(.home).instantiateViewController(withIdentifier: ViewControllers.editProfileVC) as! EditProfileVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Button Change Language Clicked
    func goToChangeLanguage() {
        self.pushToViewController(storyBoard: .home, Identifier: ViewControllers.changeLanguageVC, animated: true)
    }
    
    // MARK: - Button Credits Clicked
    func goToCredits() {
        self.pushToViewController(storyBoard: .checkout, Identifier: ViewControllers.virtualCreditsVC, animated: true)
    }
    
    func goToDeleteAccount() {
        Alerts.shared.alertMessageWithActionOkAndCancelYesNo(title:  AlertMessages.appName, message: ValidationMessages.deleteAccountValidation) {
            self.objMyProfileVM.deleteAccountApiMethod {
                accessTokenSaved = ""
                loginUserDetail = nil
                primaryAddressSaved = nil
                RootControllerProxy.shared.rootWithoutDrawer(ViewControllers.loginVC, storyboard: .main)
            }
        }
    }
}
