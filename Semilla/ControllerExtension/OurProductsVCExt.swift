//
//  OurProductsVCExt.swift
//  Semilla
//
//  Created by Netset on 26/12/23.
//

import Foundation


extension OurProductsVC: DelegatesOurProducts {
    
    // MARK: - Button Back Clicked
    func gotoBack() {
        self.popViewController(true)
    }
    
}
