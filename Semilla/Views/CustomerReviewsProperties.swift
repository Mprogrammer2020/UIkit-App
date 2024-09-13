//
//  CustomerReviewsProperties.swift
//  Semilla
//
//  Created by Netset on 25/01/24.
//

import UIKit

class CustomerReviewsProperties: UIView {

   //MARK: IBOutlet's
    @IBOutlet weak var lblCustomerReview: UILabel!
    @IBOutlet weak var tblVwCustomerReviewsList: UITableView!
        
    //MARK: Variable Declaration
    var objDelegatesCustomerReviews: DelegatesCustomerReviews?
    
    //MARK: Viewlife Cycle
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func actionBtnBack(_ sender: UIButton) {
        self.objDelegatesCustomerReviews?.goToBack()
    }
    
}
