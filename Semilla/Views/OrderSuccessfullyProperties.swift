//
//  OrderSuccessfullyProperties.swift
//  Semilla
//
//  Created by Netset on 12/03/24.
//

import UIKit

protocol DelegateOrderSuccessfully {
    func goToBack()
}
class OrderSuccessfullyProperties: UIView {

    //MARK: IBOutlet's
    @IBOutlet weak var vwSuccessfully: UIView!
    @IBOutlet weak var btnOk: UIButton!
    
    var delegateOrderSuccessfully:DelegateOrderSuccessfully?
    
    //MARK: IBAction's
    @IBAction func actionBtnOk(_ sender: UIButton) {
        delegateOrderSuccessfully?.goToBack()
    }
    
}
