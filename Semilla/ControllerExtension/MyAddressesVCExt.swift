//
//  MyAddressesVCExt.swift
//  Semilla
//
//  Created by netset on 13/12/23.
//

import Foundation


extension MyAddressesVC: DelegatesMyAddress {
    
    // MARK: Button Back Clicked
    func gotoBack() {
        self.popViewController(true)
    }
    
    // MARK: Button Add New Address Clicked
    func gotoAddNewAddress() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.pushToViewController(storyBoard: .checkout, Identifier: ViewControllers.selectAddressMapVC, animated: false)
        }
    }
    
    // MARK: - Button Callback Navigate
    func goToAddAddress() {
        self.dismiss(animated: true) {
            self.callbackNavigateToAddAddress?(nil)
        }
    }
    
    
}
