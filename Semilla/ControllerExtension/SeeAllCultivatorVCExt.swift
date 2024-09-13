//
//  SeeAllCultivatorVCExt.swift
//  Semilla
//
//  Created by Inder Sandhu on 18/12/23.
//

import Foundation

extension SeeAllCultivatorVC: DelegatesSeeAllCutivator {
    
    // MARK: - Button Back Clicked
    func gotoBack() {
        self.popViewController(true)
    }
    
}
