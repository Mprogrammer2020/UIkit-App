//
//  OrderPlacedVC.swift
//  Semilla
//
//  Created by Baljinder [iMac] on 29/01/24.
//

import UIKit

class OrderPlacedVC: UIViewController {

    //MARK: IBOutlet's
    @IBOutlet var vwProperties: OrderPlacedProperties!
    
    //MARK: Variable Declaration
    var callBackToNavigateCheckOut:(()->())?
    
    //MARK: Viewlife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vwProperties.objDelegatesOrderPlaced = self
    }
    
}
