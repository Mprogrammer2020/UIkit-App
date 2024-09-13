//
//  PaymentMethodVCExt.swift
//  Semilla
//
//  Created by Netset on 14/12/23.
//

import Foundation


extension PaymentMethodVC: DelegatesPaymentMethod {
    
    // MARK: - Button Add Card Clicked
    func gotoAddCard() {
        self.pushToViewController(storyBoard: .home, Identifier: ViewControllers.addCardVC, animated: true)
    }
    
    // MARK: - Button Next Clicked
    func gotoNext() {
        let vc = getStoryboard(.checkout).instantiateViewController(withIdentifier: ViewControllers.orderPlacedVC) as! OrderPlacedVC
        vc.callBackToNavigateCheckOut = {
            self.pushToViewController(storyBoard: .checkout, Identifier: ViewControllers.mapViewVC, animated: true)
        }
        self.present(vc, animated: true)
        
    }
    
    // MARK: - Button Back Clicked
    func gotoBack() {
        self.popViewController(true)
    }
    
}
