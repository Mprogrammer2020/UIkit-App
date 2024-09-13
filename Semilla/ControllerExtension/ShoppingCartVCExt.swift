//
//  ShoppingCartVCExt.swift
//  Semilla
//
//  Created by Netset on 05/12/23.
//

import Foundation
import UIKit

extension ShoppingCartVC: DelegatesShoppingCart,DelegateSavedAddress,DelegateSavedCard {
    
    //MARK: - Display Saved card Data
    func showSavedCard(_ request: CardListResource?) {
        debugPrint("Card No","\(request?.maskedNumber ?? "")")
        debugPrint("Card Id",request?.tokenId ?? "")
        self.objShoppingVM.arrCard = request
        self.vwProperties.lblLastFourDigits.text = "\(request?.maskedNumber ?? "")"
        self.vwProperties.lblBrandName.text = "\(request?.name ?? "")"
        let getImg = (request?.paymentMethod?.lowercased() ?? "").getCardImage
        self.vwProperties.imgVwCard.image = getImg.0
        vwProperties.btnAddCard.isHidden = false
        vwProperties.vwNoCardFound.isHidden = true
        vwProperties.isChangeCard = true
        vwProperties.vwBtnCheckout.alpha = 1
        vwProperties.btnCheckout.isUserInteractionEnabled = true
        vwProperties.btnAddCard.setTitle(AlertButtonsTitle.changeCard, for: .normal)
    }
    
    //MARK: - Display Saved Address Data
    func showSavedAddress(_ request: MyAddressesList?) {
        self.objShoppingVM.arrAddress = request
        if (request?.city ?? "") != "" {
            self.vwProperties.lblShoppingAddress.text = "\(request?.apartmentNumber ?? ""), \(request?.address ?? ""), \(request?.city ?? ""), \(request?.country ?? "")"
        } else {
            self.vwProperties.lblShoppingAddress.text = " \(request?.apartmentNumber ?? ""), \(request?.address ?? ""), \(request?.country ?? "")"
        }
        self.vwProperties.lblAddressType.text = request?.type ?? ""
        vwProperties.vWNoDeliveryAddress.isHidden = true
        vwProperties.isChangeAddress = true
        vwProperties.vwBtnCheckout.alpha = 1
        vwProperties.btnCheckout.isUserInteractionEnabled = true
        vwProperties.btnAddAddress.setTitle(AlertButtonsTitle.changeAddress, for: .normal)
        self.objShoppingVM.etaShowApiMethod(request?.id ?? 0) {
            //self.vwProperties.lblEstimatedTime.text = self.objShoppingVM.objExtrasETAModel?.eta
            self.vwProperties.showDetails(self.objShoppingVM.objTotalModelInfo, etaTime: self.objShoppingVM.objExtrasETAModel)
           // self.showAlertOrderDeliverable()
        }
    }
    
    //MARK: - Button CheckOut Clicked
    func gotoCheckOut() {
        
        if (objShoppingVM.objTotalModelInfo?.itemTotal ?? 0) < (objShoppingVM.shoppingCartData?.minimumOrderAmount ?? 0) {
            Alerts.shared.showAlert(title: AlertMessages.appName, message: ValidationMessages.orderMinimumAmount)
        } else {
            
            if objShoppingVM.arrShoppingCartData.filter({ ($0.availableStock ?? 0 ) == 0 }).count > 0 {
                Alerts.shared.showAlert(title: AlertMessages.appName, message: ValidationMessages.itemOutOfStock)
            } else {
                if (objShoppingVM.arrCard?.tokenId ?? "") == "" {
                    
                } else if (objShoppingVM.arrAddress?.id ?? 0) == 0 {
                    
                } else if objShoppingVM.isDeliverableOrder == false {
                    Alerts.shared.showAlert(title: AlertMessages.appName, message: AlertMessages.cultivatorOutsideChangeAddress)
                } else {
                    let vc = getStoryboard(.checkout).instantiateViewController(identifier: ViewControllers.confirmationVC) as! ConfirmationVC
                    vc.callBackToNavigateOrderPlacedPopUp = {
                        self.objShoppingVM.orderPlaceApiMethod { (isSuccess) in
                            if isSuccess {
                                arrCartAllData.removeAll()
                                let vc = getStoryboard(.checkout).instantiateViewController(withIdentifier: ViewControllers.orderPlacedVC) as! OrderPlacedVC
                                vc.callBackToNavigateCheckOut = {
                                    let vc = getStoryboard(.checkout).instantiateViewController(identifier: ViewControllers.mapViewVC) as! MapViewVC
                                    vc.isCommingFrom = ScreenTypes.orderPlaced
                                    vc.objMapViewVM.orderId = self.objShoppingVM.orderId
                                    self.navigationController?.pushViewController(vc, animated: true)
                                }
                                self.present(vc, animated: true)
                            } else {
                                RootControllerProxy.shared.rootWithoutDrawer(ViewControllers.tabbarVC, storyboard: .home)
                            }
                        }
                    }
                    self.present(vc, animated: true)
                }
            }
        }
    }
    
    //MARK: - Click Button Change Card
    func goToMyCards() {
        delegateSavedCard = self
        let vc = getStoryboard(.home).instantiateViewController(withIdentifier: ViewControllers.creditCardsVC) as! CreditCardVC
        vc.objCreditCardVM.isComingFromCart = "ShoppingCart"
        vc.objCreditCardVM.callbackNavigateToAddCard = { (selectCard) in
            delegateSavedCard = self
            let vc = getStoryboard(.home).instantiateViewController(withIdentifier: ViewControllers.addCardVC) as! AddCardVC
            vc.objAddCardVM.isFromShoppingCard = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
        vc.objCreditCardVM.callbackSelectCard = { (selectCard) in
            self.objShoppingVM.arrCard = selectCard
            self.vwProperties.lblLastFourDigits.text = selectCard?.maskedNumber
            self.vwProperties.lblBrandName.text = selectCard?.name
            let getImg = (selectCard?.paymentMethod?.lowercased() ?? "").getCardImage
            self.vwProperties.imgVwCard.image = getImg.0
        }
        self.present(vc, animated: true)
    }
    
    //MARK: - Click Button Change Address
    func goToMyAddresses() {
        delegateSavedAddress = self
        let vc = getStoryboard(.home).instantiateViewController(withIdentifier: ViewControllers.myAddressesVC) as! MyAddressesVC
        vc.objMyAddressesVM.isComingFrom = ScreenTypeMyAddress.isComingFromShoppingCart
        vc.callbackNavigateToAddAddress = { (selectAddress) in
            delegateSavedAddress = self
            if selectAddress == nil {
                let vc = getStoryboard(.checkout).instantiateViewController(withIdentifier: ViewControllers.selectAddressMapVC) as! SelectAddressMapVC
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                let vc = getStoryboard(.home).instantiateViewController(withIdentifier: ViewControllers.editAddressVC) as! EditAddressVC
                vc.openWith = ScreenTypes.editAddress
                vc.objEditAddressVM.objAddressData = selectAddress
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        vc.objMyAddressesVM.callbackSelectAddress = { (fullAddress) in
            self.objShoppingVM.arrAddress = fullAddress
            if (fullAddress?.city ?? "") != "" {
                self.vwProperties.lblShoppingAddress.text = "\(fullAddress?.apartmentNumber ?? ""), \(fullAddress?.address ?? ""), \(fullAddress?.city ?? ""), \(fullAddress?.country ?? "")"
            } else {
                self.vwProperties.lblShoppingAddress.text = "\(fullAddress?.apartmentNumber ?? ""), \(fullAddress?.address ?? ""), \(fullAddress?.country ?? "")"
            }
            self.vwProperties.lblAddressType.text = fullAddress?.type ?? ""
            self.objShoppingVM.etaShowApiMethod(fullAddress?.id ?? 0) {
                self.vwProperties.lblEstimatedTime.text = self.objShoppingVM.objExtrasETAModel?.eta
                self.vwProperties.showDetails(self.objShoppingVM.objTotalModelInfo, etaTime: self.objShoppingVM.objExtrasETAModel)
             //   self.showAlertOrderDeliverable()
            }
        }
        self.present(vc, animated: true)
    }
    
    //MARK: - Click Button Add Address
    func goToAddAddress() {
        delegateSavedAddress = self
        let vc = getStoryboard(.checkout).instantiateViewController(withIdentifier: ViewControllers.selectAddressMapVC) as! SelectAddressMapVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - Click Back Button
    func goToBack() {
        self.popViewController(true)
    }
    
    //MARK: - Click Button Add Card
    func goToAddCard() {
        delegateSavedCard = self
        let vc = getStoryboard(.home).instantiateViewController(withIdentifier: ViewControllers.addCardVC) as! AddCardVC
        vc.objAddCardVM.isFromShoppingCard = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goToApplyCredit() {
        vwProperties.btnCreditApply.isSelected = !vwProperties.btnCreditApply.isSelected
        if vwProperties.btnCreditApply.isSelected {
            objShoppingVM.CreditsAppliedApiMethod(objShoppingVM.arrAddress?.id ?? 0, creditsUsed: true, isLoader: true) { [self] in
                vwProperties.btnCreditApply.setImage(UIImage(named: "ic-filled-checkbox"), for: .normal)
                vwProperties.vwCreditsApplied.isHidden = false
                vwProperties.lblAppliedCreditsAmount.text = "-$\(CommonMethod.shared.convertToColombianPeso(amount: (objShoppingVM.objTotalModelInfo?.creditsUsed ?? 0)) ?? "")"
                let availableCredits = (objShoppingVM.objTotalModelInfo?.virtualCredits ?? 0) - (objShoppingVM.objTotalModelInfo?.creditsUsed ?? 0)
                vwProperties.lblAvailableCreditAmount.text = "$\(CommonMethod.shared.convertToColombianPeso(amount: (availableCredits)) ?? "")"
                vwProperties.lblcartTotalPrice.text = "$\(CommonMethod.shared.convertToColombianPeso(amount: (objShoppingVM.objTotalModelInfo?.cartTotal ?? 0)) ?? "")"
            }
        } else {
            objShoppingVM.CreditsAppliedApiMethod(objShoppingVM.arrAddress?.id ?? 0, creditsUsed: false, isLoader: true) { [self] in
                vwProperties.btnCreditApply.setImage(UIImage(named: "ic-blank-checkbox"), for: .normal)
                vwProperties.vwCreditsApplied.isHidden = true
                vwProperties.lblAppliedCreditsAmount.text = "-$\(CommonMethod.shared.convertToColombianPeso(amount: (objShoppingVM.objTotalModelInfo?.creditsUsed ?? 0)) ?? "")"
                vwProperties.lblAvailableCreditAmount.text = "$\(CommonMethod.shared.convertToColombianPeso(amount: (objShoppingVM.objTotalModelInfo?.virtualCredits ?? 0)) ?? "")"
                vwProperties.lblcartTotalPrice.text = "$\(CommonMethod.shared.convertToColombianPeso(amount: (objShoppingVM.objTotalModelInfo?.cartTotal ?? 0)) ?? "")"
            }
        }
    }
    
    func goToAvailableCredits() {
        self.pushToViewController(storyBoard: .checkout, Identifier: ViewControllers.virtualCreditsVC, animated: true)
    }
    
}
