//
//  ProductReviewsVC.swift
//  Semilla
//
//  Created by Baljinder [iMac] on 29/01/24.
//

import UIKit

class ProductReviewsVC: UIViewController {
    
    //MARK: IBOutlet's
    @IBOutlet var vwProperties: ProductReviewsProperties!
    
    //MARK: Variable Declaration
    var objProductReviewVM = ProductReviewVM()
    
    //MARK: - Viewlife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vwProperties.objDelegateProductReviews = self
        UIApplication.shared.applicationIconBadgeNumber = 0
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
    
}
