//
//  DriverReviewVC.swift
//  Semilla
//
//  Created by Baljinder [iMac] on 29/01/24.
//

import UIKit
import IQKeyboardManagerSwift

class DriverReviewVC: UIViewController {

    // MARK: IBOutlet's
    @IBOutlet var vwProperties: DriverReviewProperties!
    
    //MARK: variable Declaration
    var objDriverReviewVM = DriverReviewVM()
    
    //MARK: Viewlife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vwProperties.objDelegateDriverReviews = self
        self.vwProperties.showDetails(objDriverReviewVM.objDriver)
        UIApplication.shared.applicationIconBadgeNumber = 0
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
    
}
