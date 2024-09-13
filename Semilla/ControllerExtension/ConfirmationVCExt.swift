//
//  ConfirmationVCExt.swift
//  Semilla
//
//  Created by Netset on 15/02/24.
//

import Foundation


extension ConfirmationVC: DelegatesConfirmation {
    
    // MARK: - Click button to back
    func goToBack() {
            self.dismiss(animated: true)
    }
    
    // MARK: - click button Okay to Order Placed 
    func goToOrderPlaced() {
            self.dismiss(animated: true) {
                self.callBackToNavigateOrderPlacedPopUp?()
            }
        }
    
}
