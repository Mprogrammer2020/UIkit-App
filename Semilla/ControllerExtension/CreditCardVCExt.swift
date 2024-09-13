//
//  CreditCardVCExt.swift
//  Semilla
//
//  Created by Netset on 15/12/23.
//

import Foundation


extension CreditCardVC: DelegatesCreditCards {
    
    // MARK: - Button Back Clicked
    func gotoBack() {
        self.popViewController(true)
    }
    
    // MARK: - Button Add Card Clicked
    func gotoAddCard() {
        let viewController = getStoryboard(.home).instantiateViewController(withIdentifier: ViewControllers.addCardVC) as! AddCardVC
        viewController.objAddCardVM.totalCardCount = objCreditCardVM.objCardListResource.count
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    // MARK: - Button Add New Card Clicked
    func goToAddNewCard() {
        self.dismiss(animated: true) {
            self.objCreditCardVM.callbackNavigateToAddCard?(nil)
        }
    }
    
}
