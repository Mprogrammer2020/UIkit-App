//
//  OTPVerificationVCExt.swift
//  Semilla
//
//  Created by Netset on 29/11/23.
//

import Foundation
import UIKit

extension OTPVerificationVC:DelegatesOTP {
    
    
    //MARK: -  Button Login Clicked
    func gotoHomeScreen(_ request: OtpRequest) {
        if self.objOTPVerificationVM.isComingFromLogin == ScreenTypes.signUp {
            objOTPVerificationVM.otpApiMethodSignupVerify(request) {
                let vc = getStoryboard(.checkout).instantiateViewController(identifier: ViewControllers.registrationSuccessfulVC) as RegistrationSuccessfulVC
                vc.callBack = {
                    if isGuestUser == true {
                        if let viewControllers: [UIViewController] = self.navigationController?.viewControllers {
                            guard viewControllers.count < 4 else {
                                isGuestUser = false
                                self.navigationController?.popToViewController(viewControllers[viewControllers.count - 4], animated: true)
                                return
                            }
                        }
                    } else {
                        RootControllerProxy.shared.rootWithoutDrawer(ViewControllers.tabbarVC, storyboard: .home)
                    }
                }
                self.present(vc, animated: true)
            }
        } else if self.objOTPVerificationVM.isComingFromLogin == ScreenTypes.login  {
            objOTPVerificationVM.otpApiMethodLoginVerify(request) {
                if isGuestUser == true {
                    if let viewControllers: [UIViewController] = self.navigationController?.viewControllers {
                        guard viewControllers.count < 3 else {
                            isGuestUser = false
                            self.navigationController?.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
                            return
                        }
                    }
                } else {
                    RootControllerProxy.shared.rootWithoutDrawer(ViewControllers.tabbarVC, storyboard: .home)
                }
            }
        } else {
            objOTPVerificationVM.otpApiMethodPhoneNumberChange(request) {
                let blankController = getStoryboard(.home).instantiateViewController(withIdentifier: ViewControllers.tabbarVC) as! TabbarVC
                blankController.selectedIndex = 3
                var homeNavController:UINavigationController = UINavigationController()
                homeNavController = UINavigationController.init(rootViewController: blankController)
                homeNavController.isNavigationBarHidden = true
                UIApplication.shared.windows.first?.rootViewController = homeNavController
                UIApplication.shared.windows.first?.makeKeyAndVisible()
                Alerts.shared.showAlert(title: AlertMessages.appName, message: ValidationMessages.profileUpdated)
            }
        }
    }
    
    //MARK: -  Button Back Clicked
    func goToBack() {
        self.popViewController(true)
    }
    
    //MARK: - Button Resend OTP
    func goToResentOtp(_ request:OtpRequest) {
        objOTPVerificationVM.otpResendApiMethod(request) { [self] in
            vwProperties.remainingTime = 60
            vwProperties.updateTimer()
            vwProperties.startTimer()
            vwProperties.otpTextField1.text = ""
            vwProperties.otpTextField2.text = ""
            vwProperties.otpTextField3.text = ""
            vwProperties.otpTextField4.text = ""
//            self.vwProperties.remainingStrStack = []
        }
    }
}


