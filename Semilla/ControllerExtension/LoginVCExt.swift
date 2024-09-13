//
//  LoginVCExt.swift
//  AIattorney
//
//  Created by netset on 04/07/23.
//

import UIKit

extension LoginVC: DelegatesLogin {
    
    
    //MARK: -  Button Login Clicked
    func gotoLogin(_ request:LoginRequest) {
        objLoginVM.loginApiMethod(request) {
            let vc = getStoryboard(.main).instantiateViewController(withIdentifier: ViewControllers.otpVerificationVC) as! OTPVerificationVC
            vc.objOTPVerificationVM.isComingFromLogin =  ScreenTypes.login
            vc.objOTPVerificationVM.otpSentOnNumber = request.phoneNo
            vc.objOTPVerificationVM.countryCode = request.countryCode
            self.navigationController?.pushViewController(vc, animated: true)
            UIWindow.key.rootViewController?.showToast(message: ValidationMessages.oTPSentSuccessfully, font: appFont(name: AppStyle.Fonts.interMedium, size: 13), textColor: .black)
        }
    }
    
    //MARK: -  Sign up Button Click
    func gotoSignUp(){
        self.pushToViewController(storyBoard: .main, Identifier: ViewControllers.signupVC, animated: true)
    }
    
    func goToGuestUser() {
        isGuestUser = true
        self.pushToViewController(storyBoard: .home, Identifier: ViewControllers.tabbarVC, animated: true)
    }
    
    
    func goToChangeLang() {
        let vc = getStoryboard(.home).instantiateViewController(identifier: ViewControllers.changeLanguageVC) as! ChangeLanguageVC
        vc.isComingFromLogin = true
        navigationController?.pushViewController(vc, animated: true)
    }
}
