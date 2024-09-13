//
//  AddCardVC.swift
//  Semilla
//
//  Created by netset on 13/12/23.
//

import UIKit

class AddCardVC: UIViewController {
    
    //MARK: IBOutlet's
    @IBOutlet var vwProperties: AddCardProperties!
    
    //MARK: Variable Declaration
    var objAddCardVM = AddCardVM()
    
    //MARK: Viewlife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vwProperties.objAddCardDelegates = self
    }
    
}
