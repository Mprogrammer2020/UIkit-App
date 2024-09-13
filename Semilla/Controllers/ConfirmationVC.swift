//
//  ConfirmationVC.swift
//  Semilla
//
//  Created by Netset on 15/02/24.
//

import UIKit

class ConfirmationVC: UIViewController {

    //MARK: IBOutlet's
    @IBOutlet var vwProperties: ConfirmationProperties!
    
    //MARK: Variable Declaration
    var callBackToNavigateOrderPlacedPopUp:(()->())?
    var objConfirmationVM = ConfirmationVM()
    
    //MARK: Viewlife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vwProperties.objDelegatesConfirmationVC = self
    }


}
