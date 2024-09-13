//
//  SignUpVCExt.swift
//  Semilla
//
//  Created by Netset on 29/11/23.
//

import Foundation
import UIKit

extension SignUpVC : DelegatesSignUp {
    
    //MARK: - Sign up button clicked
    func gotoHome(_ request: SignUpRequest) {
        objSignupVM.signUpApiMethod(request) {
            let vc = getStoryboard(.main).instantiateViewController(withIdentifier: ViewControllers.otpVerificationVC) as! OTPVerificationVC
            vc.objOTPVerificationVM.isComingFromLogin = ScreenTypes.signUp
            vc.objOTPVerificationVM.otpSentOnNumber = request.phoneNo
            vc.objOTPVerificationVM.countryCode = request.countryCode
            vc.objOTPVerificationVM.firstName = request.firstName
            vc.objOTPVerificationVM.lastName = request.lastName
            self.navigationController?.pushViewController(vc, animated: true)
            UIWindow.key.rootViewController?.showToast(message: ValidationMessages.oTPSentSuccessfully, font: appFont(name: AppStyle.Fonts.interMedium, size: 13), textColor: .black)
        }
    }
    
    //MARK: Sign In button clicked 
    func gotoSignIn() {
        self.popViewController(true)
    }
    
    //MARK: - Click Privacy Policy
    func goToPrivacyPolicy() {
        let vc = getStoryboard(.home).instantiateViewController(withIdentifier: ViewControllers.aboutUsVC) as! AboutUsVC
        vc.screenTitle = DisplayNames.privacyPolicy
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - Click Terms And Conditions
    func goToTermsAndCondition() {
        let vc = getStoryboard(.home).instantiateViewController(withIdentifier: ViewControllers.aboutUsVC) as! AboutUsVC
        vc.screenTitle = DisplayNames.termsOfService
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
