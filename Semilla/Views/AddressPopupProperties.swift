//
//  AddressPopupProperties.swift
//  Semilla
//
//  Created by Netset on 22/03/24.
//

import UIKit

protocol DelegateAddressPopup {
    func goToSearchAddress(_ detail:AutoCompleteModel?)
    func goToCurrentLocation()
}

class AddressPopupProperties: UIView {

    
    //MARK: IBOutlet's
    @IBOutlet weak var addressVw: UIView!
    @IBOutlet weak var txtFldAddressSearch: UITextField!
    @IBOutlet weak var tblVwSavedAddress: UITableView!
    @IBOutlet weak var btnCurrentAddress: UIButton!
    
    var delegateAddressPopup:DelegateAddressPopup?
    
    //MARK: IBAction's
    @IBAction func actionBtnCurrentAddress(_ sender: UIButton) {
        delegateAddressPopup?.goToCurrentLocation()
    }
    
}


extension AddressPopupProperties: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == txtFldAddressSearch {
            AutoCompleteHelper.shared.didChoosedLocation(AppInitializers.shared.getCurrentViewController()) { objAddressDetail in
                self.txtFldAddressSearch.text = "\(objAddressDetail.fullAddress)"
                self.delegateAddressPopup?.goToSearchAddress(objAddressDetail)
            }
        }
        return true
    }
}
