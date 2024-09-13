//
//  HomeVCExt.swift
//  Semilla
//
//  Created by Netset on 30/11/23.
//

import Foundation
import UIKit

extension HomeVC: DelegatesHome {
    
    //MARK: -  Button Search Clicked
    func gotoSearchHistory() {
        if isGuestUser == true {
            Alerts.shared.alertMessageWithActionOkAndCancelLogin(title: AlertMessages.appName, message: AlertMessages.performLoginrequired) {
                self.pushToViewController(storyBoard: .main, Identifier: ViewControllers.loginVC, animated: true)
            }
        } else {
            self.pushToViewController(storyBoard: .home, Identifier: ViewControllers.searchHistoryVC, animated: false)
        }
    }
    
    //MARK: -  Button SeeAll Cultivator Clicked
    func gotoSeeAllCultivatorsList() {
        let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: ViewControllers.seeAllCultivatorVC) as! SeeAllCultivatorVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: -  Button SeeAll Recently Items Clicked
    func gotoSeeAllRecentlyItems() {
        let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: ViewControllers.seeAllRecentlyItemsVC) as! SeeAllRecentlyItemsVC
        vc.objSeeAllRecentlyVM.arrRecentList = objHomeVM.arrRecentList
        vc.objSeeAllRecentlyVM.arrCategoryList = objHomeVM.arrCategoryList
        vc.objSeeAllRecentlyVM.selectCategoryId = objHomeVM.selectCategoryId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: -  Button Profile Clicked
    func gotoShoppingCart() {
        if isGuestUser == true {
            Alerts.shared.alertMessageWithActionOkAndCancelLogin(title: AlertMessages.appName, message: AlertMessages.performLoginrequired) {
                self.pushToViewController(storyBoard: .main, Identifier: ViewControllers.loginVC, animated: true)
            }
        } else {
            self.pushToViewController(storyBoard: .home, Identifier: ViewControllers.shoppingCartVC, animated: true)
        }
    }
    
    //MARK: -  Button Filtered Clicked
    func gotoFilter() {
        self.pushToViewController(storyBoard: .home, Identifier: ViewControllers.filterVC, animated: true)
        
    }
    
    //MARK: -  Button Notification Clicked
    func gotoNotifications() {
        if isGuestUser == true {
            Alerts.shared.alertMessageWithActionOkAndCancelLogin(title: AlertMessages.appName, message: AlertMessages.performLoginrequired) {
                self.pushToViewController(storyBoard: .main, Identifier: ViewControllers.loginVC, animated: true)
            }
        } else {
            self.pushToViewController(storyBoard: .home, Identifier: ViewControllers.notificationsVC, animated: true)
        }
    }
    
    //MARK: -  Button Map Clicked
    func gotoAddressPopup() {
        let vc = getStoryboard(.home).instantiateViewController(withIdentifier: ViewControllers.addressPopupVC) as! AddressPopupVC
        vc.objMyAddressesVM.selectedIndex = self.objHomeVM.selectSavedAddIndex
        vc.objMyAddressesVM.callbackSelectAddress = { (selectAddress,selectIndex) in
            self.objHomeVM.selectSavedAddIndex = selectIndex
            self.vwProperties.lblLocation.text = (selectAddress?.address ?? "")
        }
        vc.objMyAddressesVM.callbackAddress = { (selectAddress) in
            self.objHomeVM.selectSavedAddIndex = -1
            self.vwProperties.lblLocation.text = (selectAddress?.fullAddress ?? "")
        }
        vc.objMyAddressesVM.callbackDismiss = {
            let controller = getStoryboard(.checkout).instantiateViewController(withIdentifier: ViewControllers.selectAddressMapVC) as! SelectAddressMapVC
            controller.objSelectAddressVM.isComing = "Home"
            controller.objSelectAddressVM.callBackToBack = { (address) in
                self.objHomeVM.selectSavedAddIndex = -1
                self.vwProperties.lblLocation.text = address?.fullAddress ?? ""
                self.popViewController(true)
            }
            self.navigationController?.pushViewController(controller, animated: true)
        }
        self.present(vc, animated: true)
    }
    
}
