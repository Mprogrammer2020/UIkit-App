//
//  CheckoutVC.swift
//  Semilla
//
//  Created by netset on 11/12/23.
//

import UIKit

class CheckoutVC: UIViewController {
    
    //MARK: IBOutlet's
    @IBOutlet var vwProperties: CheckoutProperties!
    
    //MARK: Variable Declaration
    var objViewModel = CheckoutVM()
    var driverFirstName = String()
    var driverLastName = String()
    var tblVwCheckoutListDelegates: CheckoutDelegate!
    var tblVwCheckoutListDatasource: CheckoutDataSources!
    
    //MARK: Viewlife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        intializeViewDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        delegatePushNotification = self
    }
    
    //MARK: Custom Function
    private func intializeViewDataSource() {
        vwProperties.tblVwItemsList.showsVerticalScrollIndicator = false
        self.vwProperties.objCheckoutDelegates = self
        tblVwCheckoutListDatasource = CheckoutDataSources(viewModel: objViewModel, checkoutProperties: vwProperties)
        tblVwCheckoutListDelegates = CheckoutDelegate(viewModel: objViewModel, checkoutProperties: vwProperties)
        vwProperties.tblVwItemsList.delegate = tblVwCheckoutListDelegates
        vwProperties.tblVwItemsList.dataSource = tblVwCheckoutListDatasource
        vwProperties.tblVwItemsList.reloadData()
        vwProperties.vwBlankView.isHidden = false
        appDelegateObj.globalOrderId = objViewModel.orderId
        objViewModel.getOrderDetailApiMethod { [self] in
            vwProperties.vwBlankView.isHidden = true
            vwProperties.tblVwItemsList.reloadData()
            vwProperties.setUpUIMethod(objViewModel.objOrderDetail)
            vwProperties.showDetails(objViewModel.objOrderDetail)
            self.objViewModel.getOrderReviewsApiMethod { [self] in
                vwProperties.showRating(orderDetail: objViewModel.objOrderDetail,driverReview: objViewModel.driverReview, cultivatorReview: objViewModel.cultivatorReview, etaTiming: objViewModel.objExtrasETAModel)
                vwProperties.tblVwItemsList.showsVerticalScrollIndicator = false
            }
        }
    }

}

//MARK: - Handle Push Notifications
extension CheckoutVC: DelegatePushNotification {
    
    func handlePushNotification(_ orderId: Int) {
        objViewModel.getOrderDetailApiMethod { [self] in
            vwProperties.vwBlankView.isHidden = true
            vwProperties.tblVwItemsList.reloadData()
            vwProperties.setUpUIMethod(objViewModel.objOrderDetail)
            vwProperties.showDetails(objViewModel.objOrderDetail)
            self.objViewModel.getOrderReviewsApiMethod { [self] in
                vwProperties.showRating(orderDetail: objViewModel.objOrderDetail,driverReview: objViewModel.driverReview, cultivatorReview: objViewModel.cultivatorReview, etaTiming: objViewModel.objExtrasETAModel)
                vwProperties.tblVwItemsList.showsVerticalScrollIndicator = false
            }
            UIApplication.shared.applicationIconBadgeNumber = 0
            UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        }
    }
}
