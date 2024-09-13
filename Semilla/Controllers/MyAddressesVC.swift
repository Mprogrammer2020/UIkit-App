//
//  MyAddressesVC.swift
//  Semilla
//
//  Created by netset on 11/12/23.
//

import UIKit

class MyAddressesVC: UIViewController {
    
    //MARK: IBOutlet's
    @IBOutlet var vwProperties: MyAddressesProperties!
    
    //MARK: Variable Declaration
    var objMyAddressesVM = MyAddressesVM()
    var tblVwMyAddressesDatasources: MyAddressesDatasources!
    var tblVwMyAddressesDelegates: MyAddressesDelegate!
    var callbackNavigateToAddAddress:((MyAddressesList?)->())?
    
    //MARK: Viewlife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        intializeViewDataSource()
        setupUI()
    }
    
    //MARK: Custom Function
    private func intializeViewDataSource() {
        self.vwProperties.objMyAddressDelegate = self
        tblVwMyAddressesDatasources = MyAddressesDatasources(viewModel: objMyAddressesVM, myAddressesProperties: vwProperties)
        tblVwMyAddressesDelegates = MyAddressesDelegate(viewModel: objMyAddressesVM, myAddressesProperties: vwProperties)
        vwProperties.tblVwAddressesList.delegate = tblVwMyAddressesDelegates
        vwProperties.tblVwAddressesList.dataSource = tblVwMyAddressesDatasources
        vwProperties.tblVwAddressesList.reloadData()
        
        self.tblVwMyAddressesDatasources.callBackToNavigateEditAddress = { (selectIndex) in
            if let _ = self.presentingViewController {
                self.dismiss(animated: true) {
                    self.callbackNavigateToAddAddress?(self.objMyAddressesVM.arrAddressList[selectIndex])
                }
            } else {
                let vc = getStoryboard(.home).instantiateViewController(withIdentifier: ViewControllers.editAddressVC) as! EditAddressVC
                vc.openWith = ScreenTypes.editAddress
                vc.objEditAddressVM.objAddressData = self.objMyAddressesVM.arrAddressList[selectIndex]
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        tblVwMyAddressesDelegates.didSelectCallback = { (index) in
            if let _ = self.presentingViewController {
                self.dismiss(animated: true) {
                    let detail = self.objMyAddressesVM.arrAddressList[index]
                    self.objMyAddressesVM.callbackSelectAddress?(detail)
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        objMyAddressesVM.getAddressDataApiMethod { [self] in
            vwProperties.tblVwAddressesList.reloadData()
        }
    }
    
    //MARK: - Setup UI
    func setupUI() {
        if objMyAddressesVM.isComingFrom == "Shopping Cart" {
            vwProperties.vwBtnBack.isHidden = true
            vwProperties.vwAddAddressButton.isHidden = true
            vwProperties.lblHeaderMyAddresses.isHidden = true
            vwProperties.btnAddAddress.isHidden = false
        } else {
            vwProperties.vwBtnBack.isHidden = false
            vwProperties.vwAddAddressButton.isHidden = false
            vwProperties.lblHeaderMyAddresses.isHidden = false
            vwProperties.btnAddAddress.isHidden = true
        }
    }
    
}
