//
//  SignOutVC.swift
//  Semilla
//
//  Created by netset on 29/12/23.
//

import UIKit

class SignOutVC: UIViewController {

    //MARK: IBOutlet's
    @IBOutlet var vwProperties: SignOutProperties!
    
    // MARK: CallBack Declare
    var callBackToGoRootView:(()->())?
    
    // MARK: Variable Declaration
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vwProperties.objDelegateSignOut = self
    }

}
