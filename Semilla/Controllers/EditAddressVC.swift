//
//  EditAddressVC.swift
//  Semilla
//
//  Created by netset on 11/12/23.
//

import UIKit

class EditAddressVC: UIViewController {
    
    //MARK: IBOutlet's
    @IBOutlet var vwProperties: EditAddressProperties!
    
    //MARK: Variable Declaration
    var openWith = String()
    var objAutoCompleteModel = AutoCompleteModel()
    var objEditAddressVM = EditAddressVM()
    var objDelegateSavedAddress: DelegateSavedAddress?
    
    //MARK: Viewlife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Setup UI
    func setupUI() {
        self.vwProperties.objEditAddressDelegate = self
        if openWith == ScreenTypes.editAddress {
            vwProperties.lblHeaderEditAddress.text = DisplayNames.editAddress
            vwProperties.showEditAddressDetails(objEditAddressVM.objAddressData)
        } else {
            vwProperties.lblHeaderEditAddress.text = DisplayNames.addNewAddress
            vwProperties.type = objEditAddressVM.addressType
            vwProperties.showAddressDetail(objAutoCompleteModel)
        }
    }
}
