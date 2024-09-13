//
//  MessageSentVCExt.swift
//  Semilla
//
//  Created by Netset on 25/01/24.
//

import Foundation


extension MessageSentVC: DelegatesMessageSent {
    
    // MARK: - Button Click Back
    func goToBack() {
        self.dismiss(animated: true) {
            self.callbackSubmit?()
        }
    }
    
}
