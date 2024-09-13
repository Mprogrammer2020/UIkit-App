//
//  MessageSentProperties.swift
//  Semilla
//
//  Created by Netset on 25/01/24.
//

import UIKit

class MessageSentProperties: UIView {

  //MARK: IBOutlet's
    @IBOutlet weak var vwMessageSent: UIView!
    @IBOutlet weak var imgVwMessage: UIImageView!
    @IBOutlet weak var lblSuccess: UILabel!
    @IBOutlet weak var lblConcernReceived: UILabel!
    
    
    //MARK: Variable Declaration
    var objDelegatesMessageSent: DelegatesMessageSent?
    
    //MARK: Viewlife Cycle
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    @IBAction func actionBtnOk(_ sender: UIButton) {
        self.objDelegatesMessageSent?.goToBack()
    }
    
}
