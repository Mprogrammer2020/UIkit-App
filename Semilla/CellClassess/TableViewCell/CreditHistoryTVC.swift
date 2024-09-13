//
//  CreditHistoryTVC.swift
//  Semilla
//
//  Created by Netset on 23/04/24.
//

import UIKit

class CreditHistoryTVC: UITableViewCell,Reusable {

    //MARK: - IBOutlet's
    @IBOutlet weak var lblCreditedBy: UILabel!
    @IBOutlet weak var vwLifetimeCredit: UIView!
    @IBOutlet weak var creditedAmount: UILabel!
    @IBOutlet weak var lblCreditSpentDateAndTime: UILabel!
    @IBOutlet weak var vwBackgroundSpentDateTime: UIView!
    @IBOutlet weak var vwBackgroundExpiredDateTime: UIView!
    @IBOutlet weak var lblCerditExpiredDateAndTime: UILabel!
    @IBOutlet weak var cnstHeightVwBackgroundExpired: NSLayoutConstraint!
    
    
    
    //MARK: - Viewlife Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
