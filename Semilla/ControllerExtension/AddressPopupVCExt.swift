//
//  AddressPopupVCExt.swift
//  Semilla
//
//  Created by Netset on 22/03/24.
//

import Foundation


extension AddressPopupVC: DelegateAddressPopup {
    
    // MARK: - Click button to search Address
    func goToSearchAddress(_ detail: AutoCompleteModel?) {
        self.dismiss(animated: true) {
            self.objMyAddressesVM.callbackAddress?(detail)
        }
    }
    
    // MARK: - click button to get current address
    func goToCurrentLocation() {
        self.dismiss(animated: true) {
            self.objMyAddressesVM.callbackDismiss?()
        }
    }
}
