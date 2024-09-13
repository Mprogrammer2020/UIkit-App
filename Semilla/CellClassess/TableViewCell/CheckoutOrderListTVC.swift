//
//  CheckOutOrderListTVC.swift
//  Semilla
//
//  Created by Inder Sandhu on 18/12/23.
//

import UIKit

class CheckoutOrderListTVC: UITableViewCell {
    
    //MARK: IBOutlet's
    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var lblQty: UILabel!
    @IBOutlet weak var imgVwItemImg: UIImageView!
    @IBOutlet weak var lblItemPrice: UILabel!
    @IBOutlet weak var lblItemPerGram: UILabel!
    
    //MARK: Viewlife Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
