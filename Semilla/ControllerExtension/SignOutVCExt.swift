//
//  SignOutVCExt.swift
//  Semilla
//
//  Created by netset on 29/12/23.
//

import Foundation

extension SignOutVC: DelegatesSignOut {
    
    
    // MARK: - Button Clicked To Root
    func gotoRootView() {
        self.dismiss(animated: false) {
            accessTokenSaved = ""
            loginUserDetail = nil
            primaryAddressSaved = nil
            self.callBackToGoRootView?()
        }
    }
    
    // MARK: - Button Clicked Dismiss Pop up
    func dismissPopUpView() {
        self.dismiss(animated: false)
    }
    
}
