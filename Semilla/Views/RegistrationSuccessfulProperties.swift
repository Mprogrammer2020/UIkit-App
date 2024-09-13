//
//  OrderSuccessfulProperties.swift
//  Semilla
//
//  Created by Netset on 20/12/23.
//

import UIKit

class RegistrationSuccessfulProperties: UIView {

    //MARK: IBoutlet's
    @IBOutlet weak var vwOrderSuccessful: UIView!
    @IBOutlet weak var lblSuccessful: UILabel!
    @IBOutlet weak var lblSubLabel: UILabel!
    
    //MARK: Variable Declaration
    var objRegistrationSuccessfulDelegates: DelegatesRegistrationSuccessful?
    
    //MARK: IBAction's
    @IBAction func actionBtnOkay(_ sender: UIButton) {
        self.objRegistrationSuccessfulDelegates?.gotoBack()
    }
    
}
