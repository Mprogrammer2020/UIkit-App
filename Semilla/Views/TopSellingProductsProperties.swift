//
//  TopSellingProductsProperties.swift
//  Semilla
//
//  Created by Netset on 26/12/23.
//

import UIKit

class TopSellingProductsProperties: UIView {
    
    //MARK: IBOutlet's
    @IBOutlet weak var lblHeaderTopSellingProducts: UILabel!
    @IBOutlet weak var tblVwAllSellingProductsList: UITableView!
    
    //MARK: Variables Declaration
    var objTopSellingProductsDelegate: DelegatesTopSellingProducts?
    
    //MARK: IBAction's
    @IBAction func actionBtnBack(_ sender: UIButton) {
        self.objTopSellingProductsDelegate?.gotoBack()
    }
    
}
