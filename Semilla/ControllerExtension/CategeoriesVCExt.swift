//
//  CategeoriesVCExt.swift
//  Semilla
//
//  Created by Netset on 05/12/23.
//

import Foundation
import UIKit


extension CategeoriesVC: DelegatesCategories {
    
    // MARK: Button filter Clicked
    func gotoFilter() {
        self.pushToViewController(storyBoard: .home, Identifier: ViewControllers.filterVC, animated: true)
    }
    
    // MARK: Handle Search Data Method
    func handleSearchData(_ textStr: String) {
        objcategeoriesVM.pageNumber = 0
        objcategeoriesVM.name = textStr
        objcategeoriesVM.recentlyListedApiMethod(objcategeoriesVM.selectedCategoryId, isLoader: false) { [self] in
            self.vwProperties.colVwCategeorieItems.reloadData()
        }
    }
    
    //MARK: - Click Button Notification
    func goToNotifi() {
        if isGuestUser == true {
            Alerts.shared.alertMessageWithActionOkAndCancelLogin(title: AlertMessages.appName, message: AlertMessages.performLoginrequired) {
                self.popViewController(true)
            }
        } else {
            self.pushToViewController(storyBoard: .home, Identifier: ViewControllers.notificationsVC, animated: true)
        }
    }
    
    //MARK: - Click Button ShoppingCart
    func goToShoppingCart() {
        if isGuestUser == true {
            Alerts.shared.alertMessageWithActionOkAndCancelLogin(title: AlertMessages.appName, message: AlertMessages.performLoginrequired) {
                self.popViewController(true)
            }
        } else {
            self.pushToViewController(storyBoard: .home, Identifier: ViewControllers.shoppingCartVC, animated: true)
        }
    }
}
