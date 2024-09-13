//
//  CultivatorVCExt.swift
//  Semilla
//
//  Created by Netset on 05/12/23.
//

import Foundation


extension CultivatorVC: DelegatesCultivator {
    
    //MARK: -  Handle Search Data Method
    func handleSearchData(_ textStr: String) {
        objViewModel.search = textStr
        objViewModel.pageNumber = 0
        objViewModel.cultivatorListApiMethod(false) { [self] in
            vwProperties.colVwUserList.reloadData()
        }
    }
    //MARK: -  Click Button Notification
    func goToNotifications() {
        if isGuestUser == true {
            Alerts.shared.alertMessageWithActionOkAndCancelLogin(title: AlertMessages.appName, message: AlertMessages.performLoginrequired) {
               self.popViewController(true)
            }
        } else {
            self.pushToViewController(storyBoard: .home, Identifier: ViewControllers.notificationsVC, animated: true)
        }
    }
    
    //MARK: - Click Button Shopping cart
    func goToShoppingCart() {
        if isGuestUser == true {
            Alerts.shared.alertMessageWithActionOkAndCancelLogin(title: AlertMessages.appName, message: AlertMessages.performLoginrequired) {
                self.popViewController(true)
            }
        } else {
            self.pushToViewController(storyBoard: .home, Identifier: ViewControllers.shoppingCartVC, animated: true)
        }
    }
    
    //MARK: - Click Button Filter
    func goToFilter() {
        let viewController = getStoryboard(.home).instantiateViewController(withIdentifier: ViewControllers.filterVC) as! FilterVC
        viewController.objFilterVM.distance = self.objViewModel.distanceVal
        viewController.objFilterVM.selectCategoryId = self.objViewModel.selectCategoryIdVal
        viewController.objFilterVM.selectRatingValue = self.objViewModel.selectRatingVal
        viewController.objFilterVM.callbackFilter = { (categoryVal,ratingVal,distance) in
            self.objViewModel.selectCategoryIdVal = categoryVal
            self.objViewModel.selectRatingVal = ratingVal
            self.objViewModel.distanceVal = distance
            self.objViewModel.pageNumber = 0
            self.objViewModel.cultivatorListApiMethod(false) {
                self.vwProperties.colVwUserList.reloadData()
            }
        }
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}
