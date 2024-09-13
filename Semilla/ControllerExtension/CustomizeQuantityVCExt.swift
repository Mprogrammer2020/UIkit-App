//
//  CustomizeQuantityVCExt.swift
//  Semilla
//
//  Created by netset on 12/12/23.
//

import UIKit

extension CustomizeQuantityVC: DelegatesCustomizeQuantity {
    
    // MARK: - Button Back Clicked
    func gotoBack() {
        self.dismiss(animated: false)
    }
    
//    func callApiQuantity() {
//        objCustomizeQuantityVM.quantityApiMethod(objCustomizeQuantityVM.stockId) {
//            self.vwProperties.number = (self.objCustomizeQuantityVM.quantity?.cartQuantity ?? 0)
//            if self.vwProperties.number == 0 {
//                self.vwProperties.number = 1
//            }
//            self.showDetailMethod()
//            self.vwProperties.getDetail(self.objCustomizeQuantityVM.arrQuantityUnit, viewModel: self.objCustomizeQuantityVM)
//        }
//    }
    
    // MARK: - Call Api Add Item To Cart
    func callApiAddItemToCart() {
//        objCustomizeQuantityVM.addToCartApiMethod(objCustomizeQuantityVM.quantity?.id ?? 0, quantity: vwProperties.number) { (isReplace) in
//            if !isReplace {
//                self.dismiss(animated: true) {
//                    UIWindow.key.rootViewController?.showToast(message: ValidationMessages.productAdded, font: appFont(name: AppStyle.Fonts.interMedium, size: 13), textColor: AppStyle.AppColors.appColorGreen)
//                    self.callBackToShowItemCount?()
//                }
//            } else {
//                self.objCustomizeQuantityVM.addReplacedItemTocardApiMethod(self.objCustomizeQuantityVM.quantity?.id ?? 0, quantity: self.vwProperties.number) {
//                    self.dismiss(animated: true) {
//                        UIWindow.key.rootViewController?.showToast(message: ValidationMessages.productAdded, font: appFont(name: AppStyle.Fonts.interMedium, size: 13), textColor: AppStyle.AppColors.appColorGreen)
//                        self.callBackToShowItemCount?()
//                    }
//                }
//            }
//        }
    }
}
extension CustomizeQuantityVC {
    
    //MARK: - Show Detail Data
    
    func showDetailMethod() {
//        let detail = objCustomizeQuantityVM.quantity
//        let availableStock = ((detail?.availableStock ?? 0))
//        let quantityValue = (detail?.packaging ?? 0)
//        let formatStr = NSMutableAttributedString()
//        if availableStock == 0 {
//            formatStr.attributedString("\(quantityValue)\(detail?.unit?.unit ?? "")", color: UIColor.black, font: appFont(name: AppStyle.Fonts.interMedium, size: 8), lineHeight: 1.2, align: TextAlign.left).attributedString(" (Out of stock)", color: UIColor.red, font: appFont(name: AppStyle.Fonts.interMedium, size: 8), lineHeight: 1.2, align: TextAlign.left)
//            vwProperties.vwBtnOk.alpha = 0.5
//            vwProperties.btnOk.isUserInteractionEnabled = false
//            self.vwProperties.number = 0
//            self.vwProperties.updateLabel()
//        } else {
//            formatStr.attributedString("\(quantityValue)\(detail?.unit?.unit ?? "")", color: UIColor.black, font: appFont(name: AppStyle.Fonts.interMedium, size: 8), lineHeight: 1.2, align: TextAlign.left)
//            vwProperties.vwBtnOk.alpha = 1
//            vwProperties.btnOk.isUserInteractionEnabled = true
//        }
//        vwProperties.txtFldSelectUnit.attributedText = formatStr
        
    }
}
