//
//  OrderSuccessfullyDeliveredVC.swift
//  Semilla
//
//  Created by Netset on 12/03/24.
//

import UIKit

class OrderSuccessfullyDeliveredVC: UIViewController {

    //MARK: IBOutlet's
    @IBOutlet var vwProperties: OrderSuccessfullyProperties!
    
    //MARK: - Variable Declarations
    var callbackToOkay:(()->())?
    
    //MARK: - Viewlife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vwProperties.delegateOrderSuccessfully = self
    }

}
