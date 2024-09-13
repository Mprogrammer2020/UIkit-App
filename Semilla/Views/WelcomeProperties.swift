//
//  WelcomeProperties.swift
//  Semilla
//
//  Created by netset on 29/11/23.
//

import UIKit



class WelcomeProperties: UIView {
    
    
    //MARK: IBOutlet's
    
    // MARK: Variables
    var objWelcomeDelegates: DelegatesWelcome?
    
    // MARK: View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: IBActions
    @IBAction func actionLogin(_ sender: UIButton) {
        objWelcomeDelegates?.gotoNext()
    }
    
}
