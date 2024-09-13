//
//  PaymentMethodCardListTVC.swift
//  Semilla
//
//  Created by netset on 11/12/23.
//

import UIKit

class PaymentMethodCardListTVC: UITableViewCell {

    //MARK: IBOutlet's
    @IBOutlet weak var imgVwCardType: UIImageView!
    @IBOutlet weak var lblCardCVV: UILabel!
    @IBOutlet weak var lblCardExpiryDate: UILabel!
    @IBOutlet weak var lblCardLast4Digit: UILabel!
    @IBOutlet weak var lblCardName: UILabel!
    
    //MARK: Viewlife Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
