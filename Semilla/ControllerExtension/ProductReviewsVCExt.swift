//
//  ProductReviewsVCExt.swift
//  Semilla
//
//  Created by Baljinder [iMac] on 29/01/24.
//

import Foundation

extension ProductReviewsVC: DelegateProductReviews {
    
    // MARK: - Click to Back Checkout VC
    func goToCheckout() {
        if objProductReviewVM.isFromNotify {
            goToOrderDetailMethod()
        } else {
            self.popViewController(true)
        }
    }
    
    // MARK: - Click to Submit Product review
    func goToProductReviewSubmit(_ request: ProductReviewRequest) {
        objProductReviewVM.productReviewApiMethod(request, id: objProductReviewVM.orderId) {
            if self.objProductReviewVM.isFromNotify {
                self.goToOrderDetailMethod()
            } else {
                self.objProductReviewVM.callBackAfterCultivatorReview?()
                self.popViewController(true)
            }
        }
    }
    
    // MARK: - Click to Back
    func goToOrderDetailMethod() {
        let vc = getStoryboard(.checkout).instantiateViewController(withIdentifier: ViewControllers.checkoutVC) as! CheckoutVC
        vc.objViewModel.orderId = objProductReviewVM.orderId
        vc.objViewModel.isBackToHome = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
