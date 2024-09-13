//
//  CustomerReviewsVCEXt.swift
//  Semilla
//
//  Created by Baljinder [iMac] on 31/01/24.
//

import Foundation


extension CustomerReviewsVC: DelegatesCustomerReviews {
    
    // MARK: - Click Button to Back
    func goToBack() {
        self.popViewController(true)
    }
 
}
