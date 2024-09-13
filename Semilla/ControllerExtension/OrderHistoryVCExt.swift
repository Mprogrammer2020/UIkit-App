//
//  OrderHistoryVCExt.swift
//  Semilla
//
//  Created by netset on 13/12/23.
//

import Foundation


extension OrderHistoryVC: DelegatesOrderHistory {
    
    // MARK: - Button Back Clicked
    func gotoBack() {
        self.popViewController(true)
    }
    
}
