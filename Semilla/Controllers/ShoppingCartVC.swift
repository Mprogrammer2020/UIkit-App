//
//  ShoppingCartVC.swift
//  Semilla
//
//  Created by Netset on 05/12/23.
//

import UIKit

class ShoppingCartVC: UIViewController {
    
    //MARK: IBOutlet's
    @IBOutlet var vwProperties: ShoppingCartProperties!
    
    //MARK: Variable Declaration
    var objShoppingVM = ShoppingCartVM()
    private var tblVwDataSource: ShoppingCartDatasource!
    private var tblVwDelegates: ShoppingCartDelegate!
       
    //MARK: Viewlife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.intializeViewDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    //MARK: Datasource + Delegates
    private func intializeViewDataSource() {
        self.vwProperties.objShoppingCartDelegates = self
        vwProperties.tblVwCartItems.register(UINib.init(nibName: "ShoopingCartTVC", bundle: nil), forCellReuseIdentifier: "ShoopingCartTVC")
        tblVwDataSource = ShoppingCartDatasource(viewModel: objShoppingVM, properties: vwProperties)
        tblVwDelegates = ShoppingCartDelegate(viewModel: objShoppingVM, properties: vwProperties)
        objShoppingVM.getCartData { [self] in
            vwProperties.showDetails(objShoppingVM.objTotalModelInfo,etaTime: objShoppingVM.objExtrasETAModel)
            vwProperties.tblVwCartItems.delegate = tblVwDelegates
            vwProperties.tblVwCartItems.dataSource = tblVwDataSource
            vwProperties.tblVwCartItems.reloadData()
           // showAlertOrderDeliverable()
        }
        setupUI()
   }
    
    //MARK: - Setup UI
    func setupUI() {
        objShoppingVM.getPrimaryAddressApiMethod { [self] in
            vwProperties.lblAddressType.text = objShoppingVM.arrAddress?.type ?? ""
            if (objShoppingVM.arrAddress?.city ?? "") != "" {
                vwProperties.lblShoppingAddress.text = "\(objShoppingVM.arrAddress?.apartmentNumber ?? ""), \(objShoppingVM.arrAddress?.address ?? ""),\(objShoppingVM.arrAddress?.city ?? ""), \(objShoppingVM.arrAddress?.country ?? "")"
            } else {
                vwProperties.lblShoppingAddress.text = "\(objShoppingVM.arrAddress?.apartmentNumber ?? ""),\(objShoppingVM.arrAddress?.address ?? ""),\(objShoppingVM.arrAddress?.country ?? "")"
            }
            if objShoppingVM.arrAddress?.address ?? "" != "" {
                vwProperties.vWNoDeliveryAddress.isHidden = true
                vwProperties.isChangeAddress = true
                vwProperties.btnAddAddress.setTitle(AlertButtonsTitle.changeAddress, for: .normal)
            } else {
                vwProperties.vWNoDeliveryAddress.isHidden = false
                vwProperties.isChangeAddress = false
                vwProperties.btnAddAddress.setTitle(AlertButtonsTitle.addAddress, for: .normal)
            }
//            if (objShoppingVM.arrCard?.last4 ?? "") != "" && (objShoppingVM.arrAddress?.address ?? "") != "" {
//                vwProperties.vwBtnCheckout.alpha = 1
//                vwProperties.btnCheckout.isUserInteractionEnabled = true
//            } else {
//                vwProperties.vwBtnCheckout.alpha = 0.5
//                vwProperties.btnCheckout.isUserInteractionEnabled = false
//            }
        }
        objShoppingVM.getPrimaryCardApiMethod { [self] in
            vwProperties.lblLastFourDigits.text = objShoppingVM.arrCard?.maskedNumber ?? ""
            vwProperties.lblBrandName.text = objShoppingVM.arrCard?.name ?? ""
            if objShoppingVM.arrCard?.name != nil {
                vwProperties.btnAddCard.isHidden = false
                vwProperties.vwNoCardFound.isHidden = true
                vwProperties.isChangeCard = true
                vwProperties.btnAddCard.setTitle(AlertButtonsTitle.changeCard, for: .normal)
                let getImg = (objShoppingVM.arrCard?.paymentMethod?.lowercased() ?? "").getCardImage
                vwProperties.imgVwCard.image = getImg.0
            } else {
                vwProperties.vwNoCardFound.isHidden = false
                vwProperties.btnAddCard.isHidden = false
                vwProperties.isChangeCard = false
                vwProperties.btnAddCard.setTitle(AlertButtonsTitle.addCard, for: .normal)
                vwProperties.imgVwCard.image = UIImage(named: "")
            }
            if (objShoppingVM.arrCard?.maskedNumber ?? "") != "" && (objShoppingVM.arrAddress?.address ?? "") != "" {
                vwProperties.vwBtnCheckout.alpha = 1
                vwProperties.btnCheckout.isUserInteractionEnabled = true
            } else {
                vwProperties.vwBtnCheckout.alpha = 0.5
                vwProperties.btnCheckout.isUserInteractionEnabled = false
            }
        }
        
    }
    
    // MARK: - Custom Function
    func showAlertOrderDeliverable() {
        if objShoppingVM.isDeliverableOrder == false {
            Alerts.shared.showAlert(title: AlertMessages.appName, message: AlertMessages.cultivatorOutsideChangeAddress)
        }
    }
    
}
