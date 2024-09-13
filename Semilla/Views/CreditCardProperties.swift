//
//  CreditCardProperties.swift
//  Semilla
//
//  Created by netset on 13/12/23.
//

import UIKit

class CreditCardProperties: UIView {
    
    //MARK: IBOutlet's
    @IBOutlet weak var lblHeaderCreditCards: UILabel!
    @IBOutlet weak var lblSelectCreditDebitCard: UILabel!
    @IBOutlet weak var tblVwCardsList: UITableView!
    @IBOutlet weak var btnAddCard: UIButton!
    @IBOutlet weak var vwBtnBack: UIView!
    @IBOutlet weak var btnAddNewCard: UIButton!
    @IBOutlet weak var vwNoCardFound: UIView!
    
    //MARK: Variable Declaration
    var objCreditCardsDelegate: DelegatesCreditCards?
    
    
    //MARK: IBAction's
    @IBAction func actionBtnBack(_ sender: UIButton) {
        self.objCreditCardsDelegate?.gotoBack()
    }
    
    @IBAction func actionBtnAddCard(_ sender: UIButton) {
        self.objCreditCardsDelegate?.gotoAddCard()
    }
    
    @IBAction func actionBtnAddNewCard(_ sender: UIButton) {
        self.objCreditCardsDelegate?.goToAddNewCard()
    }
}
