//
//  FilterProperties.swift
//  Semilla
//
//  Created by netset on 07/12/23.
//

import UIKit

class FilterProperties: UIView {
    
    //MARK: IBOutlet's
    @IBOutlet weak var lblHeaderFilter: UILabel!
    @IBOutlet weak var btnReset: UIButton!
    @IBOutlet weak var tblVwFilterData: UITableView!
    
    //MARK: Variable Declaration
    var objFilterDelegates: DelegatesFilter?
    
    //MARK: IBAction's
    @IBAction func actionBtnReset(_ sender: UIButton) {
        self.objFilterDelegates?.gotoReset()
    }
    
    @IBAction func actionBtnBack(_ sender: UIButton) {
        self.objFilterDelegates?.gotoBack()
    }
    
    @IBAction func actionBtnApply(_ sender: UIButton) {
        self.objFilterDelegates?.gotoApplyFilter()
    }
    
}

