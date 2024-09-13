//
//  OTPVerificationVC.swift
//  Semilla
//
//  Created by Netset on 29/11/23.
//

import UIKit

class OTPVerificationVC: UIViewController {
    
    //MARK: IBOutlet's
    @IBOutlet var vwProperties: OTPVerificationProperties!
    
    // MARK: View Model Object
    var objOTPVerificationVM = OTPVerificationVM()
    
    //MARK: Viewlife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUIMethod()
        debugPrint(objOTPVerificationVM.isComingFromLogin)
    }
    
    // MARK: Prepare UI Method
    private func prepareUIMethod() {
        vwProperties.objOtpDelegates = self
        vwProperties.setHeaderTitle(objOTPVerificationVM.otpSentOnNumber,countryCode: objOTPVerificationVM.countryCode)
        vwProperties.getData(phoneNo: objOTPVerificationVM.otpSentOnNumber, countryCode: objOTPVerificationVM.countryCode,isScreenFrom:objOTPVerificationVM.isComingFromLogin)
    }
    
}
