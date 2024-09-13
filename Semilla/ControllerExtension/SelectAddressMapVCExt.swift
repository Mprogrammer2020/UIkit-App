//
//  SelectAddressMapVCExt.swift
//  Semilla
//
//  Created by Netset on 15/12/23.
//

import Foundation
import UIKit


extension SelectAddressMapVC: DelegatesSelectAddress {
    
    // MARK: - Button Location Clicked
    func locationSaved(_ address: AutoCompleteModel) {
        
        if objSelectAddressVM.isComing == "Home" {
            self.objSelectAddressVM.callBackToBack?(address)
        } else {
            let vc = getStoryboard(.home).instantiateViewController(withIdentifier: ViewControllers.editAddressVC) as! EditAddressVC
            vc.openWith = ScreenTypes.addNewAddress
            vc.objAutoCompleteModel = address
            vc.objEditAddressVM.addressType = vwProperties.selectedAddressType
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // MARK: - Button Back Clicked
    func gotoBack() {
        self.popViewController(true)
    }

}


