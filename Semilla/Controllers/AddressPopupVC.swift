//
//  AddressPopupVC.swift
//  Semilla
//
//  Created by Netset on 22/03/24.
//

import UIKit

class AddressPopupVC: UIViewController {
    
    //MARK: IBOutlet's
    @IBOutlet var vwProperties: AddressPopupProperties!
    
    //MARK: Variable Declaration
    var objMyAddressesVM = AddressPopupVM()
    var tblVwMyAddressesDatasources: AddressPopupDataSources!
    var tblVwMyAddressesDelegates: AddressPopupDelegate!
    
    //MARK: Viewlife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        intializeViewDataSource()
    }
    
    //MARK: Custom Function
    private func intializeViewDataSource() {
        vwProperties.delegateAddressPopup = self
        tblVwMyAddressesDatasources = AddressPopupDataSources(viewModel: objMyAddressesVM, myAddressesProperties: vwProperties)
        tblVwMyAddressesDelegates = AddressPopupDelegate(viewModel: objMyAddressesVM, myAddressesProperties: vwProperties)
        if isGuestUser == false {
            objMyAddressesVM.getAddressDataApiMethod { [self] in
                vwProperties.tblVwSavedAddress.delegate = tblVwMyAddressesDelegates
                vwProperties.tblVwSavedAddress.dataSource = tblVwMyAddressesDatasources
                vwProperties.tblVwSavedAddress.reloadData()
            }
        }
        tblVwMyAddressesDelegates.didSelectCallback = { indexpath in
            let data = self.objMyAddressesVM.arrAddressList[indexpath]
            self.dismiss(animated: true) {
                self.objMyAddressesVM.callbackSelectAddress?(data, indexpath)
            }
        }
    }
    
}
