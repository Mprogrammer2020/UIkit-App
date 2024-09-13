//
//  CheckoutVCExt.swift
//  Semilla
//
//  Created by Netset on 14/12/23.
//

import UIKit

extension CheckoutVC: DelegatesCheckout {
    
    // MARK: - Button Back To Home Clicked
    func gotoBackToHome() {
        RootControllerProxy.shared.rootWithoutDrawer(ViewControllers.tabbarVC, storyboard: .home)
    }
    
    // MARK: - Button Track Order Clicked
    func gotoTrackOrder() {
        let vc = getStoryboard(.checkout).instantiateViewController(identifier: ViewControllers.mapViewVC) as! MapViewVC
        vc.isCommingFrom = ScreenTypes.OrderDetail
        vc.objMapViewVM.orderId = objViewModel.orderId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Button Back Clicked
    func gotoBack() {
        if objViewModel.isBackToHome {
            RootControllerProxy.shared.rootWithoutDrawer(ViewControllers.tabbarVC, storyboard: .home)
        } else {
            self.popViewController(true)
        }
    }
    
    // MARK: - Click Button Cancel Order
    func orderCancel() {
        Alerts.shared.alertMessageWithActionOkAndCancelYesNo(title: AlertMessages.appName, message: AlertMessages.areYouSureYouWantToCancelOrder) {
            self.objViewModel.orderCancelApiMethod(self.objViewModel.orderId) {
                self.popViewController(true)
                self.objViewModel.callBackOrderCancel?()
            }
        }
    }
    
    // MARK: - Call To Driver Button Clicked
    func goToDriverCall() {
        if let phoneCallURL = URL(string: "tel://\(objViewModel.objOrderDetail?.order?.driver?.phone ?? "")") {
            if (UIApplication.shared.canOpenURL(phoneCallURL)) {
                UIApplication.shared.open(phoneCallURL, options: [:], completionHandler: nil)
            } else {
                Alerts.shared.showAlert(title: AlertMessages.appName, message: AlertMessages.numberIsNotValid)
            }
        } else {
            Alerts.shared.showAlert(title: AlertMessages.appName, message: AlertMessages.noNumberShowing)
        }
    }
    
    // MARK: - Button Click Provide Driver Review
    func goToDriverReviews() {
        let vc = getStoryboard(.checkout).instantiateViewController(identifier: ViewControllers.driverReviewVC) as! DriverReviewVC
        vc.objDriverReviewVM.orderId = objViewModel.orderId
        vc.objDriverReviewVM.objDriver = objViewModel.objOrderDetail?.order?.driver
        vc.objDriverReviewVM.callBackAfterDriverReview = {
            self.objViewModel.getOrderReviewsApiMethod { [self] in
                vwProperties.showRating(orderDetail: objViewModel.objOrderDetail,driverReview: objViewModel.driverReview, cultivatorReview: objViewModel.cultivatorReview, etaTiming: objViewModel.objExtrasETAModel)
                vwProperties.tblVwItemsList.showsVerticalScrollIndicator = false
            }
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Button Click Provide Product Review
    func goToProductReviews() {
        let vc = getStoryboard(.checkout).instantiateViewController(identifier: ViewControllers.productReviewVC) as! ProductReviewsVC
        vc.objProductReviewVM.orderId = objViewModel.orderId
        vc.objProductReviewVM.callBackAfterCultivatorReview = {
            self.objViewModel.getOrderReviewsApiMethod { [self] in
                vwProperties.showRating(orderDetail: objViewModel.objOrderDetail,driverReview: objViewModel.driverReview, cultivatorReview: objViewModel.cultivatorReview, etaTiming: objViewModel.objExtrasETAModel)
                vwProperties.tblVwItemsList.showsVerticalScrollIndicator = false
            }
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

