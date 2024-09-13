//
//  OrderPlacedProperties.swift
//  Semilla
//
//  Created by Baljinder [iMac] on 29/01/24.
//

import UIKit

class OrderPlacedProperties: UIView {

//MARK: IBOutlet's
    @IBOutlet weak var vwSuccessful: UIView!
    @IBOutlet weak var imgVwSuccessful: UIImageView!
    @IBOutlet weak var lblSuccessful: UILabel!
    @IBOutlet weak var lblOrderDeliveredSuccessful: UILabel!
    
    //MARK: Variable Declaration
    var objDelegatesOrderPlaced: DelegatesOrderPlaced?
    
    
    //MARK: Viewlife Cycle
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    
    //MARK: IBAction's
    @IBAction func actionBtnOk(_ sender: UIButton) {
        self.objDelegatesOrderPlaced?.goToBack()
    }
}
