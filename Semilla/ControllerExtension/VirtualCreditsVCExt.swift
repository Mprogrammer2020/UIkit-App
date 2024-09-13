//
//  VirtualCreditsVCExt.swift
//  Semilla
//
//  Created by Netset on 23/04/24.
//

import Foundation


extension VirtualCreditsVC: DelegatesVirtualCredits {
    
    func goToBack() {
        self.popViewController(true)
    }
    
    func goToHome() {
        RootControllerProxy.shared.setRootTabbarScreen(0)
    }
    
    
}
extension VirtualCreditsVC: DelegatePushNotification {
    
    func handlePushNotification(_ orderId: Int) {
        objVirtualCreditsVM.pageNumber = 0
        objVirtualCreditsVM.creditsHistoryApiMethod(true) { [self] in
            vwProperties.showData(objVirtualCreditsVM.objVirtualCreditsData)
            vwProperties.tblVwCreditHistory.reloadData()
        }
    }
    
}
