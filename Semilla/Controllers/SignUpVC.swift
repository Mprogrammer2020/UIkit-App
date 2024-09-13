//
//  SignUpVC.swift
//  Semilla
//
//  Created by Netset on 29/11/23.
//

import UIKit

class SignUpVC: UIViewController {
    
    //MARK: IBOutlet's
    @IBOutlet var vwProperties: SignUpProperties!
    
    // MARK: View Model Object
    var objSignupVM = SignUpVM()
    
    //MARK: Viewlife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUIMethod()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let locationManager = LocationManager.sharedLocationManager()
        locationManager.startStandardUpdates()
    }
    
    // MARK: Prepare UI Method
    private func prepareUIMethod() {
        vwProperties.objSignUpDelegates = self
    }
    
}
