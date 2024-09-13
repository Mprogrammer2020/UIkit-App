//
//  SignUpProperties.swift
//  Semilla
//
//  Created by Netset on 29/11/23.
//

import UIKit
import AVFoundation
import CountryPickerView
import PhoneNumberKit

class SignUpProperties: UIView {
    
    // MARK: Variable Declaration
    var objSignUpDelegates:DelegatesSignUp?
    var objCountryPicker = CountryPickerView()
    var phoneNumberKit = PhoneNumberKit()
    var phoneCode = "IN"
    
    //MARK: IBOutlet's
    @IBOutlet weak var txtFldFirstName: UITextField!
    @IBOutlet weak var txtFldPhoneNumber: UITextField!
    @IBOutlet weak var txtFldLastName: UITextField!
    @IBOutlet weak var lblPrivacyPolicy: UILabel!
    @IBOutlet weak var btnPickCountryCode: UIButton!
    @IBOutlet weak var lblCountryCode: UILabel!
    @IBOutlet weak var imgVwArrowDown: UIImageView!
    
    // MARK: View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.objCountryPicker.delegate = self
        self.configurePrivacyPolicy()
        let countryCode = NSLocale.current.regionCode
        phoneCode = countryCode ?? ""
        
        let limitedCountries: [Country] = ["IN","CO", "MX", "BR", "AR", "PE", "EC","UY","CL","CR", "US", "CA"]
            .compactMap { countryCode in
                return objCountryPicker.countries.first { $0.code.uppercased() == countryCode.uppercased() }
            }
//        objCountryPicker.countries = limitedCountries
        
        let country = objCountryPicker.getCountryByCode(phoneCode)
        lblCountryCode.text = country?.phoneCode ?? ""
    }
    
    //MARK: IBAction's
    @IBAction func actionBtnPickCountryCode(_ sender: UIButton) {
        objCountryPicker.showCountriesList(from: AppInitializers.shared.getCurrentViewController())
    }
    
    @IBAction func actionBtnSignUp(_ sender: UIButton) {
        let request = SignUpRequest(firstName: txtFldFirstName.text ?? "",lastName: txtFldLastName.text ?? "", phoneNo: txtFldPhoneNumber.text ?? "",countryCode: lblCountryCode.text ?? "")
            objSignUpDelegates?.gotoHome(request)
    }
    
    @IBAction func actionBtnSignIn(_ sender: Any) {
        objSignUpDelegates?.gotoSignIn()
    }
    
}

//MARK: UI Textfield Delegate
extension SignUpProperties: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let number = "\(textField.text ?? "")"
        do {
            let phoneNumber = try phoneNumberKit.parse(number, withRegion: phoneCode, ignoreType: true)
            self.txtFldPhoneNumber.text = self.phoneNumberKit.format(phoneNumber, toType: .international)
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    // MARK: UITextField Delegate Method
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtFldFirstName {
            txtFldFirstName.goToNextTextFeild(nextTextFeild: txtFldLastName)
        }else if textField == txtFldLastName {
            txtFldLastName.goToNextTextFeild(nextTextFeild: txtFldPhoneNumber)
        } else if textField == txtFldPhoneNumber {
            txtFldPhoneNumber.resignFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == " " && range.location == 0 {
            return false
        }

       if (textField == txtFldPhoneNumber) {
            let allowedCharacterSet = CharacterSet.decimalDigits
            let replacementStringCharacterSet = CharacterSet(charactersIn: string)
            if !allowedCharacterSet.isSuperset(of: replacementStringCharacterSet) {
                return false
            }
        }
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        if textField == txtFldPhoneNumber {
            return updatedText.count <= 14
        } else {
            return updatedText.count <= 30
        }
    }
}

//MARK: Country Picker Delegate Method
extension SignUpProperties: CountryPickerViewDelegate {
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        phoneCode = country.code
        lblCountryCode.text = country.phoneCode
        txtFldPhoneNumber.text = ""
    }
}

extension SignUpProperties {
    
    func configurePrivacyPolicy() {
        let formatStr = NSMutableAttributedString()
        formatStr.attributedString(AlertMessages.byContinuingYouAgreeToOur, color: .black, font: appFont(name: AppStyle.Fonts.interMedium, size: 12), lineHeight: 1.2, align: TextAlign.left).attributedString(DisplayNames.termsOfService, color: AppStyle.AppColors.appColorGreen, font: appFont(name: AppStyle.Fonts.interMedium, size: 12), lineHeight: 1.2, align: TextAlign.left).attributedString(AlertMessages.and, color: .black, font: appFont(name: AppStyle.Fonts.interMedium, size: 12), lineHeight: 1.2, align: TextAlign.left).attributedString(DisplayNames.privacyPolicy, color: AppStyle.AppColors.appColorGreen, font: appFont(name: AppStyle.Fonts.interMedium, size: 12), lineHeight: 1.2, align: TextAlign.left)
        lblPrivacyPolicy.attributedText = formatStr
        let tapgesture = UITapGestureRecognizer()
        tapgesture.addTarget(self, action: #selector(tapLabel(_:)))
        lblPrivacyPolicy.addGestureRecognizer(tapgesture)
        lblPrivacyPolicy.isUserInteractionEnabled = true
    }
    
    @objc func tapLabel(_ gesture: UITapGestureRecognizer) {
        let termsText = (lblPrivacyPolicy.text! as NSString).range(of: DisplayNames.termsOfService)
        if gesture.didTapAttributedTextInLabel(label: lblPrivacyPolicy, inRange: termsText) {
            debugPrint(DisplayNames.termsOfService)
            objSignUpDelegates?.goToTermsAndCondition()
        }
        
        let privacyText = (lblPrivacyPolicy.text! as NSString).range(of: DisplayNames.privacyPolicy)
        if gesture.didTapAttributedTextInLabel(label: lblPrivacyPolicy, inRange: privacyText) {
            debugPrint(DisplayNames.privacyPolicy)
            objSignUpDelegates?.goToPrivacyPolicy()
        }
    }
}
