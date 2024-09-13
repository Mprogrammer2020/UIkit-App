//
//  EditAddressVCExt.swift
//  Semilla
//
//  Created by netset on 13/12/23.
//

import Foundation
import UIKit


extension EditAddressVC: DelegatesEditAddress {
    
    
    // MARK: - Button Back Clicked
    func gotoBack() {
        self.popViewController(true)
    }
    
    // MARK: - Custom Function
    func addressSave(_ request:AddAddressRequest) {
        objEditAddressVM.addAddressApiMethod(request) { (addressDetailObj) in 
            if self.openWith == ScreenTypes.editAddress {
                UIWindow.key.rootViewController?.showToast(message: AlertMessages.addressUpdatedSuccessfully, font: UIFont.systemFont(ofSize: 15), textColor: AppStyle.AppColors.appColorGreen)
                delegateSavedAddress?.showSavedAddress(addressDetailObj)
                self.popViewController(true)
            } else if self.openWith == ScreenTypes.addNewAddress {
                if self.objEditAddressVM.totalAddressCount == 0 {
                    CommonApis.shared.selectedPrimaryAddressApiMethod(addressDetailObj?.id ?? 0) {
                        UIWindow.key.rootViewController?.showToast(message: AlertMessages.addressAddedSuccessfully, font: UIFont.systemFont(ofSize: 15), textColor: AppStyle.AppColors.appColorGreen)
                        var isMyAddress = Bool()
                        for controller in (self.navigationController?.viewControllers ?? []) as Array {
                            if controller.isKind(of: MyAddressesVC.self) {
                                isMyAddress = true
                                self.navigationController?.popToViewController(controller, animated: true)
                                break
                            }
                        }
                        if !isMyAddress {
                            for controller in (self.navigationController?.viewControllers ?? []) as Array {
                                if controller.isKind(of: ShoppingCartVC.self) {
                                    delegateSavedAddress?.showSavedAddress(addressDetailObj)
                                    self.navigationController?.popToViewController(controller, animated: true)
                                    break
                                }
                            }
                        }
                    }
                }
            } else {
                self.popViewController(true)
            }
        }
    }
}


// MARK: - UI Textfield Delegate Methods
extension EditAddressVC: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == vwProperties.txtFldUsersFirstName {
            vwProperties.txtFldUsersFirstName .resignFirstResponder()
            vwProperties.txtFldUsersLastName.becomeFirstResponder()
        } else if textField == vwProperties.txtFldUsersLastName {
            vwProperties.txtFldUsersLastName.resignFirstResponder()
            vwProperties.txtFldUserPhoneNumber.becomeFirstResponder()
        } else if  textField == vwProperties.txtFldUserPhoneNumber {
            vwProperties.txtFldUserPhoneNumber.resignFirstResponder()
            vwProperties.txtFldUserCountry.becomeFirstResponder()
        } else if textField == vwProperties.txtFldUserCountry {
            vwProperties.txtFldUserCountry.resignFirstResponder()
            vwProperties.txtFldUserZipCode.becomeFirstResponder()
        } else if textField == vwProperties.txtFldUserZipCode {
            vwProperties.txtFldUserZipCode.resignFirstResponder()
            vwProperties.txtFldUserCity.becomeFirstResponder()
        }else if textField == vwProperties.txtFldUserCity {
            vwProperties.txtFldUserCity.resignFirstResponder()
            vwProperties.txtFldUsersAddress.becomeFirstResponder()
        } else if textField == vwProperties.txtFldUsersAddress {
            vwProperties.txtFldUsersAddress.resignFirstResponder()
        }
        return true
    }
    
}
