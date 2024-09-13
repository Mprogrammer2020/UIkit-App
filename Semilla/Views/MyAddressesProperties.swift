//
//  MyAddressesProperties.swift
//  Semilla
//
//  Created by netset on 11/12/23.
//

import UIKit

class MyAddressesProperties: UIView {

    //MARK: IBOutlet's
    @IBOutlet weak var lblHeaderMyAddresses: UILabel!
    @IBOutlet weak var vwBtnBack: UIView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var tblVwAddressesList: UITableView!
    @IBOutlet weak var vwAddAddressButton: Gradient!
    @IBOutlet weak var btnAddAddress: UIButton!
    @IBOutlet weak var vwNoAddressFound: UIView!
    
    //MARK: Variable Declaration
    var objMyAddressDelegate: DelegatesMyAddress?
    
    
    //MARK: IBAction's
    @IBAction func actionBtnBack(_ sender: UIButton) {
        self.objMyAddressDelegate?.gotoBack()
    }
    
    @IBAction func actionBtnAddNewAddress(_ sender: UIButton) {
        self.objMyAddressDelegate?.gotoAddNewAddress()
    }
    
    @IBAction func actionBtnAddAddress(_ sender: UIButton) {
        self.objMyAddressDelegate?.goToAddAddress()
    }
    
}
