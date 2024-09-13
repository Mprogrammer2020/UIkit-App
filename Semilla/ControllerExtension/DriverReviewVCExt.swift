//
//  DriverReviewVCExt.swift
//  Semilla
//
//  Created by Baljinder [iMac] on 29/01/24.
//

import Foundation


extension DriverReviewVC: DelegateDriverReviews {
    
    // MARK: - Button Back Click
    func goToBack() {
        if objDriverReviewVM.isBackToNotify {
            goProductRattingMethod()
        } else {
            self.popViewController(true)
        }
    }
    
    // MARK: - Buttom Click Submnit Review
    func goToReviewSubmit(_ request: DriverReviewRequest) {
        objDriverReviewVM.driverReviewApiMethod(request, id: objDriverReviewVM.orderId) {
            if self.objDriverReviewVM.isBackToNotify {
                self.goProductRattingMethod()
            } else {
                self.objDriverReviewVM.callBackAfterDriverReview?()
                self.popViewController(true)
            }
        }
    }
    
    // MARK: - Click Button to Navigate Product Rating
    func goProductRattingMethod() {
        let vc = getStoryboard(.checkout).instantiateViewController(identifier: ViewControllers.productReviewVC) as! ProductReviewsVC
        vc.objProductReviewVM.orderId = objDriverReviewVM.orderId
        vc.objProductReviewVM.isFromNotify = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
