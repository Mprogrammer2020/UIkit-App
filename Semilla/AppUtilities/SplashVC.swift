//
//  SplashVC.swift
//  Semilla
//
//  Created by netset on 29/11/23.
//

import UIKit

class SplashVC: UIViewController {

    // MARK: - Viewlife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        sleep(1)
        AppInitializers.shared.setupAppThings()
    }
    

}
