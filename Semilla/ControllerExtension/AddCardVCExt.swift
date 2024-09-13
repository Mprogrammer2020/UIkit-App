//
//  AddCardVCExt.swift
//  Semilla
//
//  Created by Netset on 19/12/23.
//

import Foundation


extension AddCardVC: DelegatesAddCard {
    
    // MARK: Button Back Clicked
    func gotoBack() {
        self.popViewController(true)
    }
    
    // MARK: - Click Text Field Select Expiry Date
    func gotoCalendar() {
        let vc = getStoryboard(.checkout).instantiateViewController(withIdentifier: ViewControllers.customCalendarVC) as! CustomCalendarVC
        vc.callbackToDataShowInTxtFld = { (selectMonths, selectYears) in
            debugPrint(selectMonths,selectYears)
            self.vwProperties.selectedYear = Int(selectYears) ?? 0
            self.vwProperties.selectedMonth = Int(selectMonths) ?? 0
            self.vwProperties.txtFldAddExpiryDate.text = "\(selectYears)/\(selectMonths)"
        }
        vc.selectedMonth = "\(vwProperties.selectedMonth)"
        vc.selectedYear = "\(vwProperties.selectedYear)"
        self.present(vc, animated: true)
    }
    
    // MARK: - Call Api To Add Card on Save Button
    func callApiAddCard(_ request: AddCardRequest) {
        objAddCardVM.addCardApiMethod(request) { (objCardDetails) in
            Alerts.shared.showAlert(title: AlertMessages.appName, message: ValidationMessages.enterCardAddedSuccess)
            if self.objAddCardVM.isFromShoppingCard {
                debugPrint("objCardDetails",objCardDetails?.tokenId ?? "")
                delegateSavedCard?.showSavedCard(objCardDetails)
                self.popViewController(true)
            } else {
                if self.objAddCardVM.totalCardCount == 0 {
                    CommonApis.shared.setPrimaryCardApiMethod(objCardDetails?.tokenId ?? "") {
                        self.goToBackMethod()
                    }
                } else {
                    self.goToBackMethod()
                }
            }
        }
    }
    
    // MARK: Go To Back Method
    func goToBackMethod() {
        var isMyCard = Bool()
        for controller in (self.navigationController?.viewControllers ?? []) as Array {
            if controller.isKind(of: CreditCardVC.self) {
                isMyCard = true
                self.navigationController?.popToViewController(controller, animated: true)
                break
            }
        }
        if !isMyCard {
            self.popViewController(true)
        }
    }
    
}
