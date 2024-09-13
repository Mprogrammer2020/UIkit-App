//
//  EditProfileProperties.swift
//  Semilla
//
//  Created by Netset on 05/02/24.
//

import UIKit
import CountryPickerView
import PhoneNumberKit

class EditProfileProperties: UIView {

   //MARK: IBOutlet's
    @IBOutlet weak var lblHeaderEditProfile: UILabel!
    @IBOutlet weak var imgVwUserImage: UIImageView!
    @IBOutlet weak var imgVwCameraBtn: UIImageView!
    @IBOutlet weak var txtFldFirstName: UITextField!
    @IBOutlet weak var txtFldLastName: UITextField!
    @IBOutlet weak var txtFldMobileNumber: UITextField!
    @IBOutlet weak var lblCountryCode: UILabel!
    
    //MARK: Variable Declaration
    var objDelegatesEditProfile: DelegatesEditProfile?
    var objCountryPicker = CountryPickerView()
    var phoneNumberKit = PhoneNumberKit()
    var phoneCode = String()

    override func awakeFromNib() {
        let limitedCountries: [Country] = ["IN","CO", "MX", "BR", "AR", "PE", "EC","UY","CL","CR","US","CA"]
            .compactMap { countryCode in
                return objCountryPicker.countries.first { $0.code.uppercased() == countryCode.uppercased() }
            }
//        objCountryPicker.countries = limitedCountries
    }
    
    //MARK: IBAction's
    @IBAction func actionBtnBack(_ sender: UIButton) {
        self.objDelegatesEditProfile?.goToBack()
    }
    
    @IBAction func actionBtnCamera(_ sender: UIButton) {
        self.objDelegatesEditProfile?.goTocamera()
    }
    
    @IBAction func actionBtnSubmit(_ sender: UIButton) {
        let request = EditProfileRequest(firstName: txtFldFirstName.text ?? "",lastName: txtFldLastName.text ?? "", phoneNo: txtFldMobileNumber.text ?? "",countryCode: lblCountryCode.text ?? "")
        self.objDelegatesEditProfile?.gotoSubmit(request)
    }
    
    @IBAction func actionBtnPickCountryCode(_ sender: UIButton) {
        self.objCountryPicker.delegate = self
        objCountryPicker.showCountriesList(from: AppInitializers.shared.getCurrentViewController())
    }
    
}
//MARK: UI Textfield Delegate
extension EditProfileProperties: UITextFieldDelegate {
    
    // MARK: UITextField Delegate Method
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtFldFirstName {
            txtFldFirstName.goToNextTextFeild(nextTextFeild: txtFldLastName)
        }else if textField == txtFldLastName {
            txtFldLastName.goToNextTextFeild(nextTextFeild: txtFldMobileNumber)
        } else if textField == txtFldMobileNumber {
            txtFldMobileNumber.resignFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let number = "\(textField.text ?? "")"
        do {
            let phoneNumber = try phoneNumberKit.parse(number, withRegion: phoneCode, ignoreType: true)
            self.txtFldMobileNumber.text = self.phoneNumberKit.format(phoneNumber, toType: .international)
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == " " && range.location == 0 {
            return false
        }
        if (textField == txtFldMobileNumber) && string == " " {
            return false
        }
        if textField == txtFldMobileNumber {
            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            return updatedText.count <= 14
        } else {
            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            return updatedText.count <= 30
        }
    }
    
}

//MARK: Country Picker Delegate Method
extension EditProfileProperties: CountryPickerViewDelegate {
    
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        lblCountryCode.text = country.phoneCode
        phoneCode = country.code
    }
    
}
extension EditProfileProperties {
    
    func showUserDetailMethod() {
        let objUser = loginUserDetail
        txtFldFirstName.text = objUser?.firstName ?? ""
        txtFldLastName.text = objUser?.lastName ?? ""
        lblCountryCode.text = objUser?.countryCode ?? ""
        let phone = objUser?.phone?.replacingOccurrences(of: objUser?.countryCode ?? "", with: "")
        imgVwUserImage.setImageOnImageViewServer(objUser?.imagePath ?? "", placeholder: UIImage(named: "ic_placeholder")!)
        let country = objCountryPicker.getCountryByPhoneCode(objUser?.countryCode ?? "")
        phoneCode = country?.code ?? ""
        let formatPhoneNo = phone?.setFormatPhoneNo(phoneCode)
        txtFldMobileNumber.text = formatPhoneNo
    }
}
