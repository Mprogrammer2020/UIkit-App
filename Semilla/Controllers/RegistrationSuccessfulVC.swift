//
//  RegistrationSuccessfulVC.swift
//  Semilla
//
//  Created by Netset on 20/12/23.
//

import UIKit

class RegistrationSuccessfulVC: UIViewController {
    
    //MARK: IBOutlet's
    @IBOutlet var vwProperties: RegistrationSuccessfulProperties!
    
    //MARK: Variable Declaration
    var callBack:(()->())?
    var timer = Timer()
    
    //MARK: Viewlife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vwProperties.objRegistrationSuccessfulDelegates = self
        timer = Timer.scheduledTimer(timeInterval: 59, target: self, selector: #selector(navigateToNextScreen), userInfo: nil, repeats: false)
    }
    
    //MARK: - Navigate To Next Screen Action's
    @objc func navigateToNextScreen() {
        self.dismiss(animated: false){
            self.callBack?()
        }
    }
    
}
