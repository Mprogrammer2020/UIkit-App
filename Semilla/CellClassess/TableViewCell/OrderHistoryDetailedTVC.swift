//
//  OrderHistoryDetailedTVC.swift
//  Semilla
//
//  Created by Netset on 22/12/23.
//

import UIKit

class OrderHistoryDetailedTVC: UITableViewCell {

    
    //MARK: IBOutlet's
    @IBOutlet weak var imgVwOrders: UIImageView!
    @IBOutlet weak var lblOrderNumber: UILabel!
    @IBOutlet weak var lblOrderPlacedOnDate: UILabel!
    @IBOutlet weak var lblNumbersOfItems: UILabel!
    @IBOutlet weak var lblOrderPrice: UILabel!
    @IBOutlet weak var btnToViewOrderStatus: UIButton!
    @IBOutlet weak var vwStatusChangeColor: UIView!
    @IBOutlet weak var lblOrderStatus: UILabel!
    @IBOutlet weak var lblOrderPlacedDate: UILabel!
    
    //MARK: Viewlife Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    //MARK: IBAction's
    @IBAction func actionBtnToViewOrderStatus(_ sender: UIButton) {
    }
    
    
}
