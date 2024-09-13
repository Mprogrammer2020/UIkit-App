//
//  CheckOutVC.swift
//  Semilla
//
//  Created by netset on 11/12/23.
//

import UIKit

class PaymentMethodVC: UIViewController {
    
    
    //MARK: IBOutlet's
    @IBOutlet var vwProperties: PaymentMethodProperties!
    
    //MARK: Variable Declaration
    var objPaymentMethodViewModel = PaymentMethodVM()
    private var tblVwPaymentMethodDelegates: PaymentMethodDelegate!
    private var tblVwPaymentMethodDatasources: PaymentMethodDataSources!
    
    //MARK: Viewlife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        intializeViewDataSource()
    }
    
    //MARK: Custom Function
    private func intializeViewDataSource() {
        self.vwProperties.objPaymentMethodDelegates = self
        tblVwPaymentMethodDelegates = PaymentMethodDelegate(viewModel: objPaymentMethodViewModel, paymentMethodProperties: vwProperties)
        tblVwPaymentMethodDatasources = PaymentMethodDataSources(viewModel: objPaymentMethodViewModel, paymentMethodProperties: vwProperties)
        vwProperties.tblVwCardList.delegate = tblVwPaymentMethodDelegates
        vwProperties.tblVwCardList.dataSource = tblVwPaymentMethodDatasources
        vwProperties.tblVwCardList.reloadData()
    }
    
}
