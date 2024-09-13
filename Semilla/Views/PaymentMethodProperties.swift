//
//  CheckOutProperties.swift
//  Semilla
//
//  Created by netset on 11/12/23.
//

import UIKit

class PaymentMethodProperties: UIView {


    //IBOutlet's
    @IBOutlet weak var lblHeaderPaymentMethod: UILabel!
    @IBOutlet weak var lblWeAreCreatingOrder: UILabel!
    @IBOutlet weak var lblUserAddress: UILabel!
    @IBOutlet weak var lblTimeInMinutes: UILabel!
    @IBOutlet weak var btnAddCard: UIButton!
    @IBOutlet weak var tblVwCardList: UITableView!
    @IBOutlet weak var actionBtnNext: UIButton!

    //MARK: Variable Declaration
    var objPaymentMethodDelegates: DelegatesPaymentMethod?
    
    //MARK: IBAction's
    @IBAction func actionBtnAddCard(_ sender: UIButton) {
        self.objPaymentMethodDelegates?.gotoAddCard()
    }
    
    @IBAction func actionBtnNext(_ sender: UIButton) {
        self.objPaymentMethodDelegates?.gotoNext()
    }
    
    @IBAction func actionBtnBack(_ sender: UIButton) {
        self.objPaymentMethodDelegates?.gotoBack()
    }
    
}
