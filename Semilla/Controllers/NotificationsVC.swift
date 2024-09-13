//
//  NotificationsVC.swift
//  Semilla
//
//  Created by netset on 11/12/23.
//

import UIKit

class NotificationsVC: UIViewController {
    
    //MARK: IBOutlet's
    @IBOutlet var vwProperties: NotificationsProperties!
    
    //MARK: Variable Declaration
    var objNotificationDelegate = NotificationsVM()
    var notificationTblVwDelegate: NotificationsDelegate!
    var notificationTblVwDatasource: NotificationsDatasources!
    
    //MARK: Viewlife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.intializeViewDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        isShowNotificationCount = false
    }
    
    //MARK: Custom Function
    private func intializeViewDataSource() {
        self.vwProperties.objNotificationDelegates = self
        notificationTblVwDatasource = NotificationsDatasources(viewModel: objNotificationDelegate, notifications: vwProperties)
        notificationTblVwDelegate = NotificationsDelegate(viewModel: objNotificationDelegate, notifications: vwProperties)
        objNotificationDelegate.notificationsApiMethod(true) { [self] in
            vwProperties.tblVwNotificationList.delegate = notificationTblVwDelegate
            vwProperties.tblVwNotificationList.dataSource = notificationTblVwDatasource
            vwProperties.tblVwNotificationList.reloadData()
        }
        notificationTblVwDelegate.callBackToNavigate = { (selectIndex) in
            let dict = self.objNotificationDelegate.arrNotificationsList[selectIndex]
            if (dict.extras?.status ?? "") == ScreenTypes.atDeliveryLocation || (dict.extras?.status ?? "") == ScreenTypes.orderAccept || (dict.extras?.status ?? "") == ScreenTypes.order_Rejected || (dict.extras?.status ?? "") == ScreenTypes.pickup_Confirmation_Pending || (dict.extras?.status ?? "") == ScreenTypes.pickup_Confirm || (dict.extras?.status ?? "") == ScreenTypes.out_For_Delivery || (dict.extras?.status ?? "") == ScreenTypes.order_Cancelled || (dict.extras?.status ?? "") == ScreenTypes.delivered || (dict.extras?.status ?? "") == ScreenTypes.order_Delievered || (dict.extras?.status ?? "") == ScreenTypes.orderPlaced || (dict.extras?.status ?? "") == ScreenTypes.order_Intiated || (dict.extras?.status ?? "") == ScreenTypes.orderTimeOut {
                let vc = getStoryboard(.checkout).instantiateViewController(withIdentifier: ViewControllers.checkoutVC) as! CheckoutVC
                vc.objViewModel.orderId = dict.extras?.orderId ?? 0
                self.navigationController?.pushViewController(vc, animated: true)
            } else if (dict.extras?.status ?? "") == ScreenTypes.virtualCredits {
                let vc = getStoryboard(.checkout).instantiateViewController(withIdentifier: ViewControllers.virtualCreditsVC) as! VirtualCreditsVC
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
}
