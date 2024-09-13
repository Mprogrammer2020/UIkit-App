//
//  OrderHistoryProperties.swift
//  Semilla
//
//  Created by netset on 13/12/23.
//

import UIKit

class OrderHistoryProperties: UIView {

    //MARK: IBOutlet's
    @IBOutlet weak var lblOrderHistoryHeader: UILabel!
    @IBOutlet weak var tblVwOrderHistoryList: UITableView!
    @IBOutlet weak var vwNoOrderHistoryFound: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: Variable Declaration
    var objOrderHistoryDelegate: DelegatesOrderHistory?

    //MARK: Variable Declaration
    @IBAction func actionBtnBack(_ sender: UIButton) {
        self.objOrderHistoryDelegate?.gotoBack()
    }
    
}
