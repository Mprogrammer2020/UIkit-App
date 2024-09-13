//
//  WelcomeVC.swift
//  Semilla
//
//  Created by netset on 29/11/23.
//

import UIKit

class WelcomeVC: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet var vwProperties: WelcomeProperties!
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUIMethod()
    }
    
    // MARK: Prepare UI Method
    private func prepareUIMethod() {
        vwProperties.objWelcomeDelegates = self
    }
    
    
}
