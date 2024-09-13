//
//  ItemDetailedVCExt.swift
//  Semilla
//
//  Created by netset on 11/12/23.
//

import Foundation
import UIKit

extension ItemDetailedVC: DelegatesItemDetailed {
    
    // MARK: - Button Go To Cart Clicked
    func goToCart() {
        self.pushToViewController(storyBoard: .home, Identifier: ViewControllers.shoppingCartVC, animated: true)
    }
    
    // MARK: - Button Add To Cart Clicked
    func goToAddToCart() {
        if isGuestUser == true {
            Alerts.shared.alertMessageWithActionOkAndCancelLogin(title: AlertMessages.appName, message: AlertMessages.performLoginrequired) {
                self.pushToViewController(storyBoard: .main, Identifier: ViewControllers.loginVC, animated: true)
            }
        } else {
            if objViewModel.objProductDetail?.quantity ?? 0 <= 0 {
                Alerts.shared.showAlert(title: AlertMessages.appName, message: AlertMessages.outOfStock)
            } else {
                let totalCount = (self.objViewModel.objProductDetail?.cartQuantity ?? 0) + 1
                CommonApis.shared.getIncrDecreItemDataCount(objViewModel.productId, quantity: totalCount) { (objCartModel) in
                    if (objCartModel?.data?.Replace ?? "") == "True" {
                        Alerts.shared.alertMessageWithActionOkAndCancelYesNo(title: AlertMessages.appName, message: objCartModel?.message ?? "") {
                            self.objViewModel.addReplacedItemTocardApiMethod(self.objViewModel.productId) {
                                saveAllLocalCartDataMethod()
                                UIWindow.key.rootViewController?.showToast(message: ValidationMessages.productAdded, font: appFont(name: AppStyle.Fonts.interMedium, size: 13), textColor: AppStyle.AppColors.appColorGreen)
                                self.objViewModel.objProductDetail?.cartQuantity = totalCount
                                self.showCartItemDetail()
                                self.objViewModel.isChangedValue = true
                                setAllLocalCartDataMethod(self.objViewModel.productId, count: totalCount)
                            }
                        }
                    } else {
                        UIWindow.key.rootViewController?.showToast(message: ValidationMessages.productAdded, font: appFont(name: AppStyle.Fonts.interMedium, size: 13), textColor: AppStyle.AppColors.appColorGreen)
                        self.objViewModel.objProductDetail?.cartQuantity = totalCount
                        self.showCartItemDetail()
                        self.objViewModel.isChangedValue = true
                        setAllLocalCartDataMethod(self.objViewModel.productId, count: totalCount)
                    }
                }
            }
        }
    }

    // MARK: - Button Back Clicked
    func gotoBack() {
        self.popViewController(true)
        if objViewModel.isChangedValue {
            objViewModel.callBackRefreshListData?()
        }
    }
    
    // MARK: - Customize Pop up Button Clicked
    func gotoCustomizePopup() {
        self.presentToViewController(storyBoard: .checkout, Identifier: ViewControllers.customizeQtyVC, animated: false)
    }
    
    // MARK: - Customer Reviews Button Clicked
    func goToCustomerReviews() {
        let vc = getStoryboard(.home).instantiateViewController(withIdentifier: ViewControllers.cultivatorsDetailedVC) as! CultivatorsDetailedVC
        vc.objCultivatorsDetailedViewModel.cultivatorId = objViewModel.objProductDetail?.cultivator?.id ?? 0
        vc.objCultivatorsDetailedViewModel.isComingFrom = "ItemDetailed"
        vc.objCultivatorsDetailedViewModel.firstName = objViewModel.objProductDetail?.cultivator?.firstName ?? ""
        vc.objCultivatorsDetailedViewModel.lastName = objViewModel.objProductDetail?.cultivator?.lastName ?? ""
        vc.objCultivatorsDetailedViewModel.Image = objViewModel.objProductDetail?.cultivator?.imagePath ?? ""
        vc.objCultivatorsDetailedViewModel.rating = objViewModel.objProductDetail?.cultivator?.cultivator?.rating ?? 0
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    // MARK: - Decrease Item Count Button Clicked
    func goToDecrementItem() {
        let currentCount = (self.objViewModel.objProductDetail?.cartQuantity ?? 0)
        if currentCount >= 1 {
            CommonApis.shared.getIncrDecreItemDataCount(objViewModel.productId, quantity: (currentCount - 1)) { (objCartModel) in
                self.objViewModel.objProductDetail?.cartQuantity = (currentCount - 1)
                self.showCartItemDetail()
                self.objViewModel.isChangedValue = true
                setAllLocalCartDataMethod(self.objViewModel.productId, count: (currentCount - 1))
            }
        }
    }
    
    // MARK: - Increase Item Count Button Clicked
    func goToIncrementItem() {
        if objViewModel.objProductDetail?.quantity ?? 0 == 0 {
            Alerts.shared.showAlert(title: AlertMessages.appName, message: AlertMessages.itemHasOutOfStock)
        } else {
            let currentCount = (self.objViewModel.objProductDetail?.cartQuantity ?? 0)
            if currentCount < (self.objViewModel.objProductDetail?.quantity ?? 0) {
                CommonApis.shared.getIncrDecreItemDataCount(objViewModel.productId, quantity: (currentCount + 1)) { (objCartModel) in
                    self.objViewModel.objProductDetail?.cartQuantity = (currentCount + 1)
                    self.showCartItemDetail()
                    self.objViewModel.isChangedValue = true
                    setAllLocalCartDataMethod(self.objViewModel.productId, count: (currentCount + 1))
                }
            } else {
                let currentController = AppInitializers.shared.getCurrentViewController()
                currentController.showToast(message: AlertMessages.maximumQuantitLimitReached, font: appFont(name: AppStyle.Fonts.interMedium, size: 13), textColor: AppStyle.AppColors.appColorGreen)
            }
        }
    }
}

extension ItemDetailedVC {
    
    // MARK: - Show Filled Data Details
    func showCartItemDetail() {
        if (objViewModel.objProductDetail?.cartQuantity ?? 0) > 0 {
            vwProperties.vwAddedItemCountWithButtons.isHidden = false
            vwProperties.lblItemCount.text = "\(objViewModel.objProductDetail?.cartQuantity ?? 0)"
            vwProperties.isAddToCart = false
            self.vwProperties.lblAddToCart.text = AlertButtonsTitle.goToCart
        } else {
            vwProperties.vwAddedItemCountWithButtons.isHidden = true
            vwProperties.isAddToCart = true
            self.vwProperties.lblAddToCart.text = AlertButtonsTitle.addToCart
        }
        self.vwProperties.colVwItemDetails.reloadData()
    }
    
    
}
