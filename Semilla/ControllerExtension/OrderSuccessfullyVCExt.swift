//
//  OrderSuccessfullyVCExt.swift
//  Semilla
//
//  Created by Netset on 12/03/24.
//

import Foundation


extension OrderSuccessfullyDeliveredVC: DelegateOrderSuccessfully {
    
    // MARK: - Click button to back
    func goToBack() {
        DispatchQueue.main.async {
            self.dismiss(animated: true) {
                self.callbackToOkay?()
            }
        }
    }
    
}
