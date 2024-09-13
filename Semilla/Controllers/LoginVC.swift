//
//  LoginVC.swift
//  AIattorney
//
//  Created by netset on 03/07/23.
//

import UIKit

class LoginVC: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet var vwProperties: LoginProperties!
    
    // MARK: View Model Object
    var objLoginVM = LoginVM()
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUIMethod()
    }
    
    // MARK: Prepare UI Method
    private func prepareUIMethod() {
        vwProperties.objLoginDelegates = self
        let locationManager = LocationManager.sharedLocationManager()
        locationManager.startStandardUpdates()
    }
    
}
