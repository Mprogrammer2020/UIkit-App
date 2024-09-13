//
//  WelcomeVCExt.swift
//  Semilla
//
//  Created by netset on 29/11/23.
//

import UIKit

extension WelcomeVC: DelegatesWelcome {
    
    //MARK: -  Button Login Clicked
    func gotoNext() {
        self.pushToViewController(storyBoard: .main, Identifier: ViewControllers.loginVC, animated: true)
    }
    
}
