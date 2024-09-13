//
//  OrderHistoryDetailsVCExt.swift
//  Semilla
//
//  Created by Netset on 15/12/23.
//

import Foundation


extension OrderHistoryDetailedVC: DelegatesOrderHistoryDetailed {
    
    // MARK: - Button Back Clicked
    func gotoBack() {
        self.popViewController(true)
    }
    
}
