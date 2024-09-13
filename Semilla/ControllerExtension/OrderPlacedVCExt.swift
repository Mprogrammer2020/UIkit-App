//
//  OrderPlacedVCExt.swift
//  Semilla
//
//  Created by Baljinder [iMac] on 29/01/24.
//

import Foundation

extension OrderPlacedVC: DelegatesOrderPlaced {
    
    // MARK: - Button Back Click
    func goToBack() {
        self.dismiss(animated: true) {
            self.callBackToNavigateCheckOut?()
        }
    }
    
}
