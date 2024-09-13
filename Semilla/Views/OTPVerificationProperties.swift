//
//  OTPVerificationProperties.swift
//  Semilla
//
//  Created by Netset on 29/11/23.
//

import UIKit


class OTPVerificationProperties: UIView {
    
    // MARK: Variable Declaration
    var objOtpDelegates:DelegatesOTP?
    var remainingTime = 60
    var timer: Timer?
//    var remainingStrStack: [String] = []
    var objOTPVerificationVM = OTPVerificationVM()
    var getPhoneNumber: String?
    var getCountryCode: String?
    var backgroundTask: UIBackgroundTaskIdentifier = .invalid
    
    //MARK: IBOutlet's
    @IBOutlet weak var lblOtpSentToNumber: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var vwTextFiled1: UIView!
    @IBOutlet weak var vwTextFiled2: UIView!
    @IBOutlet weak var vwTextFiled3: UIView!
    @IBOutlet weak var vwTextFiled4: UIView!
    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var btnResend: UIButton!
//    @IBOutlet var txtFldOtpColl: [OTPTextField]!
        
    @IBOutlet weak var otpTextField1: UITextField!
    @IBOutlet weak var otpTextField2: UITextField!
    @IBOutlet weak var otpTextField3: UITextField!
    @IBOutlet weak var otpTextField4: UITextField!
    
    
    // MARK: View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        startTimer()
//        addOTPFields()
        let textFields = [otpTextField1, otpTextField2, otpTextField3, otpTextField4]
        for textField in textFields {
            textField?.delegate = self
            textField?.keyboardType = .numberPad
            textField?.textAlignment = .center
            textField?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            textField?.textContentType = .oneTimeCode
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
    }
    
    //MARK: IBAction's
    @IBAction func actionBtnBack(_ sender: UIButton) {
        objOtpDelegates?.goToBack()
    }
    
    @IBAction func actionBtnResendOTP(_ sender: Any) {
        let request = OtpRequest(countryCode: getCountryCode ?? "", phone: getPhoneNumber ?? "")
        objOtpDelegates?.goToResentOtp(request)
    }
    
    @IBAction func actionBtnSubmit(_ sender: Any) {
        let otp = getOTP()
        let request = OtpRequest(countryCode: getCountryCode ?? "", otp: otp, phone: getPhoneNumber ?? "")
        objOtpDelegates?.gotoHomeScreen(request)
    }
    
    // MARK: OTP Timer
    func startTimer() {
        timer?.invalidate()
        timer =  Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if remainingTime > 0 {
            remainingTime -= 1
            let minutes = remainingTime / 60
            let seconds = remainingTime % 60
            lblTimer.text = String(format: "%02d:%02d", minutes, seconds)
            btnResend.setTitleColor(AppStyle.AppColors.vwColorLightBlue, for: .normal)
            btnResend.isUserInteractionEnabled = false
        } else {
            stopTimer()
            btnResend.setTitleColor(AppStyle.AppColors.appColorGreen, for: .normal)
            btnResend.isUserInteractionEnabled = true
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func timeString(time:TimeInterval) -> String {
        let seconds = Int(time) % 60
        return String(format:"%02i", seconds)
    }
    
}

//MARK: UITextField  Delegate Methods
extension OTPVerificationProperties: UITextFieldDelegate {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, text.count >= 1 {
            switch textField {
            case otpTextField1:
                otpTextField2.becomeFirstResponder()
            case otpTextField2:
                otpTextField3.becomeFirstResponder()
            case otpTextField3:
                otpTextField4.becomeFirstResponder()
            case otpTextField4:
                otpTextField4.resignFirstResponder()
            default:
                break
            }
        }
    }
    
    // MARK: Text Field Delegate Method
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == " " && range.location == 0{
            return false
        }
        if ((textField.text?.count)! < 1  && string.count > 0) {
            if(textField == otpTextField1) {
                otpTextField2.becomeFirstResponder()
            }
            if(textField == otpTextField2) {
                otpTextField3.becomeFirstResponder()
            }
            if (textField == otpTextField3) {
                otpTextField4.becomeFirstResponder()
            }
            if (textField == otpTextField4) {
                otpTextField4.resignFirstResponder()
            }
            textField.text = string
            return false
        } else if ((textField.text?.count)! >= 1  && string.count == 0) {
            if(textField == otpTextField4) {
                otpTextField3.becomeFirstResponder()
            }
            if (textField == otpTextField3) {
                otpTextField2.becomeFirstResponder()
            }
            if(textField == otpTextField2) {
                otpTextField1.becomeFirstResponder()
            }
            textField.text = ""
            return false
        }
        else if (textField.text?.count) == 0 {
        } else if ((textField.text?.count)! >= 1  ) {
            if(textField == otpTextField1) {
                otpTextField2.becomeFirstResponder()
            }
            if(textField == otpTextField2) {
                otpTextField3.becomeFirstResponder()
            }
            if(textField == otpTextField3){
                otpTextField4.becomeFirstResponder()
            }
            if (textField == otpTextField4) {
                otpTextField4.resignFirstResponder()
            }
            textField.text = string
            return false
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case otpTextField1:
            otpTextField1.goToNextTextFeild(nextTextFeild: otpTextField2)
        case otpTextField2:
            otpTextField2.goToNextTextFeild(nextTextFeild: otpTextField3)
        case otpTextField3:
            otpTextField3.goToNextTextFeild(nextTextFeild: otpTextField4)
        case otpTextField4:
            otpTextField4.resignFirstResponder()
        default:
            return true
        }
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == otpTextField1 {
            vwTextFiled1.layer.borderColor = AppStyle.AppColors.appColorGreen.cgColor
        } else if textField == otpTextField2 {
            vwTextFiled2.layer.borderColor = AppStyle.AppColors.appColorGreen.cgColor
        } else if textField == otpTextField3 {
            vwTextFiled3.layer.borderColor = AppStyle.AppColors.appColorGreen.cgColor
        } else {
            vwTextFiled4.layer.borderColor = AppStyle.AppColors.appColorGreen.cgColor
        }
        return true
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == otpTextField1 {
            if textField.isBlank {
                vwTextFiled1.layer.borderColor = AppStyle.AppColors.vwColorLightBlue.cgColor
            } else {
                vwTextFiled1.layer.borderColor = AppStyle.AppColors.vwColorLightBlue.cgColor
            }
        } else if textField == otpTextField2 {
            if textField.isBlank {
                vwTextFiled2.layer.borderColor = AppStyle.AppColors.vwColorLightBlue.cgColor
            } else {
                vwTextFiled2.layer.borderColor = AppStyle.AppColors.vwColorLightBlue.cgColor
            }
        } else if textField == otpTextField3 {
            if textField.isBlank {
                vwTextFiled3.layer.borderColor = AppStyle.AppColors.vwColorLightBlue.cgColor
            } else {
                vwTextFiled3.layer.borderColor = AppStyle.AppColors.vwColorLightBlue.cgColor
            }
        } else {
            if textField.isBlank {
                vwTextFiled4.layer.borderColor = AppStyle.AppColors.vwColorLightBlue.cgColor
            } else {
                vwTextFiled4.layer.borderColor = AppStyle.AppColors.vwColorLightBlue.cgColor
            }
        }
    }
    
    // MARK: Get Otp Method
    func getOTP() -> String {
        var OTP = ""
        OTP = "\(otpTextField1.text ?? "")" + "\(otpTextField2.text ?? "")" + "\(otpTextField3.text ?? "")" + "\(otpTextField4.text ?? "")"
        return OTP
    }
}
//extension OTPVerificationProperties: UITextFieldDelegate {
//    
//    // MARK: Text Field Delegate Method
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if string == " " {
//            return false
//        }
//        guard let textField = textField as? OTPTextField else { return true }
//        if string.count > 1 {
//            textField.resignFirstResponder()
//            autoFillTextField(with: string)
//            return false
//        } else {
//            if (range.length == 0) {
//                if textField.nextTextField == nil {
//                    if textField.isBlank {
//                        textField.text? = string
//                    }
//                    textField.resignFirstResponder()
//                } else {
//                    if textField.isBlank {
//                        textField.text? = string
//                    }
//                    textField.nextTextField?.becomeFirstResponder()
//                }
//                return false
//            }
//            return true
//        }
//    }
//    
//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        if textField == txtFldOtpColl[0] {
//            vwTextFiled1.layer.borderColor = AppStyle.AppColors.appColorGreen.cgColor
//        } else if textField == txtFldOtpColl[1] {
//            vwTextFiled2.layer.borderColor = AppStyle.AppColors.appColorGreen.cgColor
//        } else if textField == txtFldOtpColl[2] {
//            vwTextFiled3.layer.borderColor = AppStyle.AppColors.appColorGreen.cgColor
//        } else {
//            vwTextFiled4.layer.borderColor = AppStyle.AppColors.appColorGreen.cgColor
//        }
//        return true
//    }
//    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        if textField == txtFldOtpColl[0] {
//            if textField.isBlank {
//                vwTextFiled1.layer.borderColor = AppStyle.AppColors.vwColorLightBlue.cgColor
//            } else {
//                vwTextFiled1.layer.borderColor = AppStyle.AppColors.vwColorLightBlue.cgColor
//            }
//        } else if textField == txtFldOtpColl[1] {
//            if textField.isBlank {
//                vwTextFiled2.layer.borderColor = AppStyle.AppColors.vwColorLightBlue.cgColor
//            } else {
//                vwTextFiled2.layer.borderColor = AppStyle.AppColors.vwColorLightBlue.cgColor
//            }
//        } else if textField == txtFldOtpColl[2] {
//            if textField.isBlank {
//                vwTextFiled3.layer.borderColor = AppStyle.AppColors.vwColorLightBlue.cgColor
//            } else {
//                vwTextFiled3.layer.borderColor = AppStyle.AppColors.vwColorLightBlue.cgColor
//            }
//        } else {
//            if textField.isBlank {
//                vwTextFiled4.layer.borderColor = AppStyle.AppColors.vwColorLightBlue.cgColor
//            } else {
//                vwTextFiled4.layer.borderColor = AppStyle.AppColors.vwColorLightBlue.cgColor
//            }
//        }
//    }
//    
//}
//
//extension OTPVerificationProperties {
//    
//    // MARK: Configure Otp Textfiels Method
//    func addOTPFields() {
//        for index in 0..<txtFldOtpColl.count {
//            let field = txtFldOtpColl[index]
//            index != 0 ? (field.previousTextField = txtFldOtpColl[index-1]) : (field.previousTextField = nil)
//            index != 0 ? (txtFldOtpColl[index-1].nextTextField = field) : ()
//        }
//        txtFldOtpColl[0].becomeFirstResponder()
//    }
//    
//    // MARK: Autofill Textfield Starting From First
//    func autoFillTextField(with string: String) {
//        remainingStrStack = string.reversed().compactMap{String($0)}
//        for textField in txtFldOtpColl {
//            if let charToAdd = remainingStrStack.popLast() {
//                textField.text = String(charToAdd)
//            } else {
//                break
//            }
//        }
//        remainingStrStack = []
//    }
//    
//    // MARK: Get Otp Method
//    func getOTP() -> String {
//        var OTP = ""
//        for textField in txtFldOtpColl {
//            OTP += textField.text ?? ""
//        }
//        return OTP
//    }
//}
//
//
//// MARK: Custom Class For Otp
//class OTPTextField: UITextField {
//    
//    weak var previousTextField: OTPTextField?
//    weak var nextTextField: OTPTextField?
//    
//    override public func deleteBackward() {
//        text = ""
//        previousTextField?.becomeFirstResponder()
//    }
//}
extension OTPVerificationProperties {
    
    // MARK: Set Header Title Method  Enter the OTP sent to +1-8565825421
    func setHeaderTitle(_ phoneNo: String,countryCode: String) {
        let formatStr = NSMutableAttributedString()
        formatStr.attributedString(AlertMessages.enterTheOTPSentTo, color: UIColor(hexString: "7C7C7C"), font: appFont(name: AppStyle.Fonts.interMedium, size: 12), lineHeight: 1.2, align: TextAlign.center).attributedString("\(countryCode) \(phoneNo)", color: UIColor(hexString: "191919"), font: appFont(name: AppStyle.Fonts.interMedium, size: 12), lineHeight: 1.2, align: TextAlign.center)
        lblOtpSentToNumber.attributedText = formatStr
    }
    
    func getData(phoneNo:String, countryCode:String,isScreenFrom:String){
        getCountryCode = countryCode
        getPhoneNumber = phoneNo
        objOTPVerificationVM.isComingFromLogin = isScreenFrom
        
    }
}

extension OTPVerificationProperties {
    
    @objc func applicationDidEnterBackground() {
           // Start a background task
           backgroundTask = UIApplication.shared.beginBackgroundTask { [weak self] in
               // Clean up code when background task expires
               self?.endBackgroundTask()
           }
           // Keep the timer running in the background
           if timer != nil {
               startTimer()
           }
       }
       
       func endBackgroundTask() {
           UIApplication.shared.endBackgroundTask(backgroundTask)
           backgroundTask = .invalid
       }
    
}
