//
//  RegistrationSuccessfulVCExt.swift
//  Semilla
//
//  Created by Netset on 20/12/23.
//

import Foundation


extension RegistrationSuccessfulVC: DelegatesRegistrationSuccessful {
    
    // MARK: - Button Back Clicked
    func gotoBack() {
        timer.invalidate()
        self.dismiss(animated: false){
            self.callBack?()
        }
    }
    
}
