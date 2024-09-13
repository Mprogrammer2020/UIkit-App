//
//  EditAddressProperties.swift
//  Semilla
//
//  Created by netset on 11/12/23.
//

import UIKit
import CountryPickerView
import PhoneNumberKit

class EditAddressProperties: UIView {
    
    //MARK: IBOutlet's
    @IBOutlet weak var lblHeaderEditAddress: UILabel!
    @IBOutlet weak var txtFldUsersFirstName: UITextField!
    @IBOutlet weak var txtFldUsersLastName: UITextField!
    @IBOutlet weak var txtFldUserPhoneNumber: UITextField!
    @IBOutlet weak var txtFldUserCountry: UITextField!
    @IBOutlet weak var txtFldUserZipCode: UITextField!
    @IBOutlet weak var txtFldUserCity: UITextField!
    @IBOutlet weak var txtFldUsersAddress: UITextField!
    @IBOutlet weak var btnSaveAddress: UIButton!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var vwTxtFldWithCountryCode: UIView!
    @IBOutlet weak var lblCountryCode: UILabel!
    
    //MARK:  Variable Declaration
    var objEditAddressDelegate: DelegatesEditAddress?
    var objCountryPicker = CountryPickerView()
    var type = String()
    var phoneNumberKit = PhoneNumberKit()
    var phoneCode = String()
    var lat = Double()
    var long = Double()
    
    // MARK: View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.prepareUI()
    }
    
    //MARK: Custom Function
    func prepareUI() {
        self.txtFldUsersFirstName.delegate = self
        self.txtFldUsersLastName.delegate = self
        self.txtFldUserPhoneNumber.delegate = self
        self.txtFldUserCountry.delegate = self
        self.txtFldUserZipCode.delegate = self
        self.txtFldUserCity.delegate = self
        self.txtFldUsersAddress.delegate = self
        self.objCountryPicker.delegate = self
        let limitedCountries: [Country] = ["IN","CO", "MX", "BR", "AR", "PE", "EC","UY","CL","CR","US","CA"]
            .compactMap { countryCode in
                return objCountryPicker.countries.first { $0.code.uppercased() == countryCode.uppercased() }
            }
//        objCountryPicker.countries = limitedCountries
        
    }
    
    //MARK: IBAction's
    @IBAction func actionBtnSaveAddress(_ sender: UIButton) {
        btnSaveAddress.isSelected = !btnSaveAddress.isSelected
        if btnSaveAddress.isSelected {
            btnSaveAddress.setImage(UIImage(named: "ic-filled-checkbox"), for: .normal)
        } else {
            btnSaveAddress.setImage(UIImage(named: "ic-blank-checkbox"), for: .normal)
        }
    }
    
    @IBAction func actionBtnSave(_ sender: UIButton) {
        let request = AddAddressRequest(firstName: txtFldUsersFirstName.text ?? "", lastName: txtFldUsersLastName.text ?? "", country: txtFldUserCountry.text ?? "",countryCode:lblCountryCode.text ?? "",mobileNo: txtFldUserPhoneNumber.text ?? "", address: txtFldUsersAddress.text ?? "", apartmentNumber: txtFldUserZipCode.text ?? "", city: txtFldUserCity.text ?? "", type: type,latitude: lat,longitude: long)
        self.objEditAddressDelegate?.addressSave(request)
    }
    
    @IBAction func actionBtnBack(_ sender: UIButton) {
        self.objEditAddressDelegate?.gotoBack()
    }
    
    @IBAction func actionBtnCountryCodePicker(_ sender: UIButton) {
        objCountryPicker.showCountriesList(from: AppInitializers.shared.getCurrentViewController())
    }
    
}

//MARK: Country Picker Delegate Method
extension EditAddressProperties: CountryPickerViewDelegate {
    
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        self.txtFldUserCountry.text = country.name
        lblCountryCode.text = country.phoneCode
        self.phoneCode = country.code
        if !txtFldUserPhoneNumber.isBlank {
            let number = txtFldUserPhoneNumber.text ?? ""
            let formatPhoneNo = number.setFormatPhoneNo(phoneCode)
            txtFldUserPhoneNumber.text = formatPhoneNo
        }
    }
}

//MARK: UI TextField Delegate Methods
extension EditAddressProperties: UITextFieldDelegate {
    
    // MARK: UITextField Delegate Method
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtFldUsersFirstName {
            txtFldUsersFirstName.goToNextTextFeild(nextTextFeild: txtFldUsersLastName)
        } else if textField == txtFldUsersLastName {
            txtFldUsersLastName.goToNextTextFeild(nextTextFeild: txtFldUserPhoneNumber)
        }else if textField == txtFldUserPhoneNumber {
            txtFldUserPhoneNumber.goToNextTextFeild(nextTextFeild: txtFldUserCountry)
        }else if textField == txtFldUserCountry {
            txtFldUserCountry.goToNextTextFeild(nextTextFeild: txtFldUserZipCode)
        }else if textField == txtFldUserZipCode {
            txtFldUserZipCode.goToNextTextFeild(nextTextFeild: txtFldUserCity)
        }else if textField == txtFldUserCity {
            txtFldUserCity.goToNextTextFeild(nextTextFeild: txtFldUsersAddress)
        }else if textField == txtFldUserZipCode {
            txtFldUsersAddress.resignFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let number = "\(textField.text ?? "")"
        do {
            let phoneNumber = try phoneNumberKit.parse(number, withRegion: phoneCode, ignoreType: true)
            self.txtFldUserPhoneNumber.text = self.phoneNumberKit.format(phoneNumber, toType: .international)
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtFldUsersFirstName {
            txtFldUsersFirstName.layer.borderColor = AppStyle.AppColors.appColorGreen.cgColor
            txtFldUsersFirstName.layer.borderWidth = 1.5
        } else if textField == txtFldUsersLastName {
            txtFldUsersLastName.layer.borderColor = AppStyle.AppColors.appColorGreen.cgColor
            txtFldUsersLastName.layer.borderWidth = 1.5
        } else if textField == txtFldUserCountry {
            txtFldUserCountry.layer.borderColor = AppStyle.AppColors.appColorGreen.cgColor
            txtFldUserCountry.layer.borderWidth = 1.5
            objCountryPicker.showCountriesList(from: AppInitializers.shared.getCurrentViewController())
        } else if textField == txtFldUserPhoneNumber {
            vwTxtFldWithCountryCode.layer.borderColor = AppStyle.AppColors.appColorGreen.cgColor
            vwTxtFldWithCountryCode.layer.borderWidth = 1.5
        } else if textField == txtFldUsersAddress {
            txtFldUsersAddress.layer.borderColor = AppStyle.AppColors.appColorGreen.cgColor
            txtFldUsersAddress.layer.borderWidth = 1.5
            AutoCompleteHelper.shared.didChoosedLocation(AppInitializers.shared.getCurrentViewController()) { objAddressDetail in
                let streetAddress = objAddressDetail.citySelect //"\(objAddressDetail.fullAddress.split(separator: ",")[0]), "
                let address = objAddressDetail.fullAddress.replacingOccurrences(of: streetAddress, with: "")
                let newAddress = (address.first) == "," ? String(address.dropFirst()) : address
                var arrAdd = newAddress.split(separator: ",")
                arrAdd.removeAll { $0 == " " || $0 == "" }
                if arrAdd.count > 1 {
                    self.txtFldUsersAddress.text = "\(arrAdd[0]), \((arrAdd[1]))"
                } else if arrAdd.count > 0 {
                    self.txtFldUsersAddress.text = "\(arrAdd[0])"
                } else {
                    self.txtFldUsersAddress.text = ""
                }
                self.txtFldUserZipCode.text = objAddressDetail.street
                self.txtFldUserCity.text = objAddressDetail.citySelect
                self.lat = objAddressDetail.latitudeDouble
                self.long = objAddressDetail.longitudeDouble
                self.txtFldUsersAddress.layer.borderColor = AppStyle.AppColors.vwColorLightBlue.cgColor
                self.txtFldUsersAddress.layer.borderWidth = 1.5
            }
        } else if textField == txtFldUserZipCode {
            txtFldUserZipCode.layer.borderColor = AppStyle.AppColors.appColorGreen.cgColor
            txtFldUserZipCode.layer.borderWidth = 1.5
        } else {
            txtFldUserCity.layer.borderColor = AppStyle.AppColors.appColorGreen.cgColor
            txtFldUserCity.layer.borderWidth = 1.5
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == txtFldUsersFirstName {
            txtFldUsersFirstName.layer.borderColor = AppStyle.AppColors.borderColor.cgColor
            txtFldUsersFirstName.layer.borderWidth = 1.5
        } else if textField == txtFldUsersLastName {
            txtFldUsersLastName.layer.borderColor = AppStyle.AppColors.borderColor.cgColor
            txtFldUsersLastName.layer.borderWidth = 1.5
        } else if textField == txtFldUserCountry {
            txtFldUserCountry.layer.borderColor = AppStyle.AppColors.borderColor.cgColor
            txtFldUserCountry.layer.borderWidth = 1.5
        } else if textField == txtFldUserPhoneNumber {
            vwTxtFldWithCountryCode.layer.borderColor = AppStyle.AppColors.borderColor.cgColor
            vwTxtFldWithCountryCode.layer.borderWidth = 1.5
        } else if textField == txtFldUsersAddress {
            txtFldUsersAddress.layer.borderColor = AppStyle.AppColors.borderColor.cgColor
            txtFldUsersAddress.layer.borderWidth = 1.5
        } else if textField == txtFldUserZipCode {
            txtFldUserZipCode.layer.borderColor = AppStyle.AppColors.borderColor.cgColor
            txtFldUserZipCode.layer.borderWidth = 1.5
        } else {
            txtFldUserCity.layer.borderColor = AppStyle.AppColors.borderColor.cgColor
            txtFldUserCity.layer.borderWidth = 1.5
        }
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == " " && range.location == 0 {
            return false
        }
//        if textField == txtFldUsersFirstName {
//            let allowedCharacterSet = CharacterSet.letters
//            let replacementStringCharacterSet = CharacterSet(charactersIn: string)
//            if !allowedCharacterSet.isSuperset(of: replacementStringCharacterSet) {
//                return false
//            }
//        } else if (textField == txtFldUsersLastName) {
//            let allowedCharacterSet = CharacterSet.letters
//            let replacementStringCharacterSet = CharacterSet(charactersIn: string)
//            if !allowedCharacterSet.isSuperset(of: replacementStringCharacterSet) {
//                return false
//            }
//        }
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        if textField == txtFldUserCity {
            return updatedText.count <= 50
        } else {
            return updatedText.count <= 30
        }
    }
}

//MARK: Address Passing
extension EditAddressProperties {
    
    func showAddressDetail(_ addressObj:AutoCompleteModel) {
        txtFldUserCity.text = "\(addressObj.citySelect)"
        txtFldUserZipCode.text = addressObj.street
        txtFldUserCountry.text = addressObj.country
        lat = addressObj.latitudeDouble
        long = addressObj.longitudeDouble
        let streetAddress = addressObj.street
        let address = addressObj.fullAddress.replacingOccurrences(of: streetAddress, with: "")
        let newAddress = (address.first) == "," ? String(address.dropFirst()) : address
        var arrAdd = newAddress.split(separator: ",")
        arrAdd.removeAll(where: { $0 == " " || $0 == "" })
        if arrAdd.count > 1 {
            self.txtFldUsersAddress.text = "\(arrAdd[0]), \((arrAdd[1]))"
        } else if arrAdd.count > 0 {
            self.txtFldUsersAddress.text = "\(arrAdd[0])"
        } else {
            self.txtFldUsersAddress.text = ""
        }
        txtFldUsersFirstName.text = loginUserDetail?.firstName ?? ""
        txtFldUsersLastName.text = loginUserDetail?.lastName ?? ""
        let countryCode = loginUserDetail?.countryCode ?? ""
        lblCountryCode.text = countryCode
        phoneCode = countryCode
        let number = loginUserDetail?.phone?.replacingOccurrences(of: countryCode, with: "")
        let formatPhoneNo = number?.setFormatPhoneNo(phoneCode)
        txtFldUserPhoneNumber.text = formatPhoneNo        
    }
    
    func showEditAddressDetails(_ addressObj:MyAddressesList?) {
        txtFldUsersFirstName.text = addressObj?.firstName ?? ""
        txtFldUsersLastName.text = addressObj?.lastName ?? ""
        txtFldUserCountry.text = addressObj?.country ?? ""
        
        let countryCode = addressObj?.countryCode ?? ""
        lblCountryCode.text = countryCode
        phoneCode = countryCode
        
        let number = addressObj?.phone?.replacingOccurrences(of: countryCode, with: "")
        let formatPhoneNo = number?.setFormatPhoneNo(phoneCode)
        txtFldUserPhoneNumber.text = formatPhoneNo
        
        txtFldUsersAddress.text = addressObj?.address ?? ""
        txtFldUserZipCode.text = addressObj?.apartmentNumber ?? ""
        txtFldUserCity.text = "\(addressObj?.city ?? "")"
        type = addressObj?.type ?? ""
        
    }
}
