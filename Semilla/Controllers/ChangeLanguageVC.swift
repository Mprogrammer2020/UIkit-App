//
//  ChangeLanguageVC.swift
//  Semilla
//
//  Created by Netset on 21/03/24.
//

import UIKit

class ChangeLanguageVC: UIViewController {

    //MARK: - IBOutlet's
    @IBOutlet var vwProperties: ChangeLanguageProperties!
    
    //MARK: - Variable Declration
    var objChangeLanguageVM = ChangeLanguageVM()
    var isComingFromLogin = Bool()
    
    //MARK: -  Viewlife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vwProperties.objDelegatesChangeLanguage = self
    }


}
