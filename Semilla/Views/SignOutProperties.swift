//
//  SignOutProperties.swift
//  Semilla
//
//  Created by netset on 29/12/23.
//

import UIKit

class SignOutProperties: UIView {
    
    //MARK: IBOutlet's
    @IBOutlet weak var imgVwSignOut: UIImageView!
    @IBOutlet weak var lblSureWantToSignout: UILabel!
    
    //MARK: Variable Declaration
    var objDelegateSignOut: DelegatesSignOut?    
    
    // MARK: View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: IBAction's
    @IBAction func actionBtnNo(_ sender: UIButton) {
        self.objDelegateSignOut?.dismissPopUpView()
    }
    
    @IBAction func actionBtnYes(_ sender: UIButton) {
        self.objDelegateSignOut?.gotoRootView()
    }
    
}
