//
//  TopSellingProductsVCExt.swift
//  Semilla
//
//  Created by Netset on 26/12/23.
//

import Foundation

extension TopSellingProductsVC: DelegatesTopSellingProducts {
    
    // MARK: - Button Back Clicked
    func gotoBack() {
        self.popViewController(true)
    }
    
}
