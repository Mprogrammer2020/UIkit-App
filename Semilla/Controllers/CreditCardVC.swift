//
//  CreditCardVC.swift
//  Semilla
//
//  Created by netset on 13/12/23.
//

import UIKit

class CreditCardVC: UIViewController {
    
    //MARK: IBOutlet's
    @IBOutlet var vwProperties: CreditCardProperties!
    
    //MARK: Variable Declaration
    var objCreditCardVM = CreditCardsVM()
    private var tblVwCreditCardDataSource: CreditCardDataSources!
    private var tblVwCreditCardDelegates: CreditCardDelegates!
    
    //MARK: Viewlife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        intializeViewDataSource()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        objCreditCardVM.getCardListApiMethod { [self] in
            objCreditCardVM.selectedCardId = payuCardId
            vwProperties.tblVwCardsList.delegate = tblVwCreditCardDelegates
            vwProperties.tblVwCardsList.dataSource = tblVwCreditCardDataSource
            vwProperties.tblVwCardsList.reloadData()
        }
    }
    
    //MARK: Custom Function
    private func intializeViewDataSource() {
        self.vwProperties.objCreditCardsDelegate = self
        tblVwCreditCardDataSource = CreditCardDataSources(viewModel: objCreditCardVM, creditCardProperties: vwProperties)
        tblVwCreditCardDelegates = CreditCardDelegates(viewModel: objCreditCardVM, creditCardProperties: vwProperties)
        
        tblVwCreditCardDelegates.didSelectCallBack = { indexPath in
            if let _ = self.presentingViewController {
                self.dismiss(animated: true) {
                    let detail = self.objCreditCardVM.objCardListResource[indexPath]
                    self.objCreditCardVM.callbackSelectCard?(detail)
                }
            }            
        }
    }
    
    // MARK: - Stup UI
    func setupUI() {
        if objCreditCardVM.isComingFromCart == "ShoppingCart" {
            vwProperties.vwBtnBack.isHidden = true
            vwProperties.lblHeaderCreditCards.isHidden = true
            vwProperties.btnAddCard.isHidden = true
            vwProperties.btnAddNewCard.isHidden = false
        } else {
            vwProperties.vwBtnBack.isHidden = false
            vwProperties.lblHeaderCreditCards.isHidden = false
            vwProperties.btnAddCard.isHidden = false
            vwProperties.btnAddNewCard.isHidden = true
        }
    }
    
}
