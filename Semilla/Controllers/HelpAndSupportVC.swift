//
//  HelpAndSupportVC.swift
//  Semilla
//
//  Created by Netset on 19/12/23.
//

import UIKit

class HelpAndSupportVC: UIViewController {
    
    //MARK: IBOutlet's
    @IBOutlet var vwProperties: HelpAndSupportProperties!
    
    //MARK: Variable Declaration
    var objViewModel = HelpAndSupportVM()
    
    //MARK: Viewlife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
            self.vwProperties.showData() 
        self.vwProperties.objHelpAndSupportDelegates = self
    }
    
}
