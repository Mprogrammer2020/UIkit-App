//
//  SelectAddressMapVC.swift
//  Semilla
//
//  Created by Netset on 15/12/23.
//

import UIKit

class SelectAddressMapVC: UIViewController {
    
    //MARK: IBOutlet's
    @IBOutlet var vwProperties: SelectAddressMapProperties!
    
    //MARK: IBOutlet's
    var objSelectAddressVM = SelectAddressVM()
    
    //MARK: Viewlife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vwProperties.objSelectAddressDelegates = self
        vwProperties.officeBtnSelected()
        setupUI()
    }
    
    //MARK: - Setup UI
    func setupUI() {
        if objSelectAddressVM.isComing == "Home" {
            vwProperties.lblBtnText.text = AlertButtonsTitle.submit
            vwProperties.vwStackData.isHidden = true
            vwProperties.cnstHeightVwStack.constant = 0
            vwProperties.cnstVwSearchAddress.constant = 220
        } else {
            vwProperties.vwStackData.isHidden = false
            vwProperties.cnstHeightVwStack.constant = 55
            vwProperties.cnstVwSearchAddress.constant = 275
            vwProperties.lblBtnText.text = AlertButtonsTitle.next
        }
        
    }
    
    
}
