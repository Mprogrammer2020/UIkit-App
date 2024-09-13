//
//  OrderHistoryDetailedProperties.swift
//  Semilla
//
//  Created by Netset on 22/12/23.
//

import UIKit

class OrderHistoryDetailedProperties: UIView {

    //MARK: IBOutlet's
    @IBOutlet weak var lblHeaderOrderHistory: UILabel!
    @IBOutlet weak var vWUpcomingAndComplete: UIView!
    @IBOutlet weak var tblVwOrderStatus: UITableView!
    @IBOutlet weak var constHeightVwUpcomingAndComplete: NSLayoutConstraint!
    
    //MARK: Variable Declaration
    var objOrderHistoryDetailedDelegates: DelegatesOrderHistoryDetailed?
    
    //MARK: Viewlife Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.vWUpcomingAndComplete.isHidden = true
        self.constHeightVwUpcomingAndComplete.constant = 0
    }
    
    //MARK: IBAction's
    @IBAction func actionBtnBack(_ sender: UIButton) {
        self.objOrderHistoryDetailedDelegates?.gotoBack()
    }
    
}
