//
//  CustomizeQuantityVC.swift
//  Semilla
//
//  Created by netset on 12/12/23.
//

import UIKit

class CustomizeQuantityVC: UIViewController {
    
    // MARK: IBOutlet's
    @IBOutlet var vwProperties: CustomizeQuantityProperties!
    
    var objCustomizeQuantityVM = CustomizeQuantityVM()
    var callBackToShowItemCount:(()->())?
    
    //MARK: Viewlife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Stup UI
    func setupUI() {
        self.vwProperties.objCustomizeQuantityDelegates = self
//        callApiQuantity()
    }
    
}
