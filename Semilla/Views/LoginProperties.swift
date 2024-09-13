//
//  LoginProperties.swift
//  AIattorney
//
//  Created by netset on 04/07/23.
//

import UIKit
import AVFoundation
import CountryPickerView
import PhoneNumberKit

class LoginProperties: UIView {
    
    // MARK: IBOutlets
    @IBOutlet weak var txtFldPhoneNo: UITextField!
    @IBOutlet weak var lblCountryCode: UILabel!
    @IBOutlet weak var imgVwArrowDown: UIImageView!
    @IBOutlet weak var btnPickCountryCode: UIButton!
    @IBOutlet weak var cnstTopMainDetail: NSLayoutConstraint!
    @IBOutlet weak var btnChangeLanguage: UIButton!
    @IBOutlet weak var lblChangeLanguage: UILabel!
    
    
    // MARK: Variables
    var objLoginDelegates:DelegatesLogin?
    var objCountryPicker = CountryPickerView()
    var objViewModel = LoginVM()
    var phoneNumberKit = PhoneNumberKit()
    var phoneCode = "IN"
    
    // MARK: View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.objCountryPicker.delegate = self
        let countryCode = NSLocale.current.regionCode
        phoneCode = countryCode ?? ""
        
        let limitedCountries: [Country] = ["IN","CO", "MX", "BR", "AR", "PE", "EC","UY","CL","CR", "US", "CA"]
            .compactMap { countryCode in
                return objCountryPicker.countries.first { $0.code.uppercased() == countryCode.uppercased() }
            }
//        objCountryPicker.countries = limitedCountries
        
        let country = objCountryPicker.getCountryByCode(phoneCode)
        lblCountryCode.text = country?.phoneCode ?? ""
        
        if preferredLang == "en" {
            lblChangeLanguage.text = ValidationMessages.english
        } else  {
            lblChangeLanguage.text = ValidationMessages.spanish
        }
        
    }
    
    // MARK: IBActions
    @IBAction func actionBtnPickCountryCode(_ sender: UIButton) {
        objCountryPicker.showCountriesList(from: AppInitializers.shared.getCurrentViewController())
    }
    
    @IBAction func actionLogin(_ sender: UIButton) {
        let request = LoginRequest(phoneNo: "\(txtFldPhoneNo.text ?? "")",countryCode: lblCountryCode.text ?? "")
        self.objLoginDelegates?.gotoLogin(request)
    }
    
    @IBAction func actionBtnSignUp(_ sender: Any) {
        objLoginDelegates?.gotoSignUp()
    }
    
    @IBAction func btnGuestUserLogin(_ sender: UIButton) {
        objLoginDelegates?.goToGuestUser()
    }
    
    
    @IBAction func actionBtnChangeLang(_ sender: UIButton) {
        objLoginDelegates?.goToChangeLang()
    }
    
    
}

extension LoginProperties: UITextFieldDelegate {

    func textFieldDidChangeSelection(_ textField: UITextField) {
        let number = "\(textField.text ?? "")"
        do {
            let phoneNumber = try phoneNumberKit.parse(number, withRegion: phoneCode, ignoreType: true)
            self.txtFldPhoneNo.text = self.phoneNumberKit.format(phoneNumber, toType: .international)
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    // MARK: UITextField Delegate Method
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtFldPhoneNo {
            txtFldPhoneNo.resignFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string == " " && range.location == 0 {
            return false
        }
        
        if textField == txtFldPhoneNo {
            let allowedCharacterSet = CharacterSet.decimalDigits
            let replacementStringCharacterSet = CharacterSet(charactersIn: string)
            if !allowedCharacterSet.isSuperset(of: replacementStringCharacterSet) {
                return false
            }
        }
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= 13
    }
        
}

//MARK: Country Picker Delegate Method
extension LoginProperties: CountryPickerViewDelegate {
    
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        phoneCode = country.code
        lblCountryCode.text = country.phoneCode
        txtFldPhoneNo.text = ""
    }
    
}
