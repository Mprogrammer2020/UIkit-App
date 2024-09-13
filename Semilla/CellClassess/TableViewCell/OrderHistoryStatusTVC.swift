//
//  OrderHistoryStatusTVC.swift
//  Semilla
//
//  Created by Netset on 22/12/23.
//

import UIKit

class OrderHistoryStatusTVC: UITableViewCell {

    
    //MARK: IBOutlet's
    @IBOutlet weak var vwOrderPlacedPoint: UIView!
    @IBOutlet weak var vwLine1: UIView!
    @IBOutlet weak var vwLine2: UIView!
    @IBOutlet weak var vwOrderShippedPoint: UIView!
    @IBOutlet weak var vwLine3: UIView!
    @IBOutlet weak var vwLine4: UIView!
    @IBOutlet weak var vwOrderConfirmedPoint: UIView!
    @IBOutlet weak var vwLine5: UIView!
    @IBOutlet weak var vwLine6: UIView!
    @IBOutlet weak var vwOrderOutForDeliveryPoint: UIView!
    @IBOutlet weak var vwLine7: UIView!
    @IBOutlet weak var vwLine8: UIView!
    @IBOutlet weak var vwOrderDeliveredPoint: UIView!
    @IBOutlet weak var lblOrderPlacedDate: UILabel!
    @IBOutlet weak var lblOrderConfirmedDate: UILabel!
    @IBOutlet weak var lblOrderShippedDate: UILabel!
    @IBOutlet weak var lblOutForDeliveryDate: UILabel!
    @IBOutlet weak var lblOrderDeliveredDate: UILabel!
    
    //MARK: Viewlife Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
