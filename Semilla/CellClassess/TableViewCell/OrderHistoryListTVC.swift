//
//  OrderHistoryListTVC.swift
//  Semilla
//
//  Created by netset on 13/12/23.
//

import UIKit

class OrderHistoryListTVC: UITableViewCell,Reusable {
    
    //MARK: IBOutlet's
    @IBOutlet weak var imgVwOrders: UIImageView!
    @IBOutlet weak var lblOrderNumber: UILabel!
    @IBOutlet weak var lblOrderPlacedOnDate: UILabel!
    @IBOutlet weak var lblNumbersOfItems: UILabel!
    @IBOutlet weak var lblOrderPrice: UILabel!
    @IBOutlet weak var vwStatusChangeColor: UIView!
    @IBOutlet weak var lblOrderStatus: UILabel!
    @IBOutlet weak var lblOrderPlacedDate: UILabel!
    @IBOutlet weak var lblOrderName: UILabel!
    
    //MARK: Viewlife Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
