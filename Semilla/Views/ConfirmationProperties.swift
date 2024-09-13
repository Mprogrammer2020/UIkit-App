//
//  ConfirmationProperties.swift
//  Semilla
//
//  Created by Netset on 15/02/24.
//

import UIKit

class ConfirmationProperties: UIView {

//MARK: IBOutlet's
    @IBOutlet weak var vwConfirmation: UIView!
    @IBOutlet weak var imgVwAskConfirmation: UIImageView!
    @IBOutlet weak var lblConfirmation: UILabel!
    @IBOutlet weak var lblWantToProceed: UILabel!
    
    //MARK: Variable Declaration
    var objDelegatesConfirmationVC: DelegatesConfirmation?
    
   //MARK: Viewlife cycle
    override class func awakeFromNib() {
        
    }
    
    //MARK: IBAction's
    @IBAction func actionBtnYes(_ sender: UIButton) {
        objDelegatesConfirmationVC?.goToOrderPlaced()
    }
    
    @IBAction func actionBtnNo(_ sender: UIButton) {
        objDelegatesConfirmationVC?.goToBack()
    }
    
}
