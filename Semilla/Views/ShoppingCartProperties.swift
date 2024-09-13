//
//  ShoppingCartProperties.swift
//  Semilla
//
//  Created by Netset on 05/12/23.
//

import UIKit

class ShoppingCartProperties: UIView {

//MARK: IBOutlet's
    @IBOutlet weak var lblHeaderShoppingCart: UILabel!
    @IBOutlet weak var tblVwCartItems: UITableView!
    @IBOutlet weak var vwBillDetails: UIView!
    @IBOutlet weak var vwItemsTotal: UIView!
    @IBOutlet weak var vwDeliveryFee: UIView!
    @IBOutlet weak var vwTaxesAndCharge: UIView!
    @IBOutlet weak var lblBillDetails: UILabel!
    @IBOutlet weak var lblIetmsTotal: UILabel!
    @IBOutlet weak var lblItemsTotalPrice: UILabel!
    @IBOutlet weak var lblDeliveryFee: UILabel!
    @IBOutlet weak var lblDeliveryFeePrice: UILabel!
    @IBOutlet weak var lblTaxesAndCharge: UILabel!
    @IBOutlet weak var lblTaxesAndChargePrice: UILabel!
    @IBOutlet weak var btnCheckout: UIButton!
    @IBOutlet weak var tblVwShoppingCartHeightConst: NSLayoutConstraint!
    @IBOutlet weak var vwBottomBillDetails: UIView!
    @IBOutlet weak var vwBottomTotalOrder: UIView!
    @IBOutlet weak var vwShowComment: UIView!
    @IBOutlet weak var showCommentNoItemFound: UILabel!
    @IBOutlet weak var vwDeliveryAddress: UIView!
    @IBOutlet weak var btnAddAddress: UIButton!
    @IBOutlet weak var btnAddCard: UIButton!
    @IBOutlet weak var lblcartTotalPrice: UILabel!
    @IBOutlet weak var vWNoDeliveryAddress: UIView!
    @IBOutlet weak var vwNoCardFound: UIView!
    @IBOutlet weak var lblAddressType: UILabel!
    @IBOutlet weak var vwBtnCheckout: Gradient!
    @IBOutlet weak var lblLastFourDigits: UILabel!
    @IBOutlet weak var lblBrandName: UILabel!
    @IBOutlet weak var imgVwCard: UIImageView!
    @IBOutlet weak var lblEstimatedTime: UILabel!
    @IBOutlet weak var lblAddressName: UILabel!
    @IBOutlet weak var btnToolTip: UIButton!
    @IBOutlet weak var btnCreditApply: UIButton!
    @IBOutlet weak var lblWantToApplyCredit: UILabel!
    @IBOutlet weak var lblAvailableCreditAmount: UILabel!
    @IBOutlet weak var vwCreditsApplied: UIView!
    @IBOutlet weak var cnstHeightVwCreditsApplied: NSLayoutConstraint!
    @IBOutlet weak var lblAppliedCreditsAmount: UILabel!
    @IBOutlet weak var vwWantToApplyCredit: UIView!
    
    @IBOutlet weak var cnstHeightVwWantToApply: NSLayoutConstraint!
    
    @IBOutlet weak var lblShoppingAddress: UILabel!
    
    //MARK: Variable Declaration
    var objShoppingCartDelegates: DelegatesShoppingCart?
    var isChangeAddress = Bool()
    var isChangeCard = Bool()
    var popTip = Popover()
    var popoverOptions: [PopoverOption] = [
            .type(.up),
            .blackOverlayColor(UIColor(white: 0.0, alpha: 0.4))
        ]
    
    //MARK: IBAction's
    
    @IBAction func actionBtnCheckout(_ sender: Any) {
        self.objShoppingCartDelegates?.gotoCheckOut()
    }
    
    @IBAction func actionBtnAddAddress(_ sender: UIButton) {
        if isChangeAddress == true {
            self.objShoppingCartDelegates?.goToMyAddresses()
        } else {
            self.objShoppingCartDelegates?.goToAddAddress()
        }
    }
    
    @IBAction func actionBtnBack(_ sender: UIButton) {
        self.objShoppingCartDelegates?.goToBack()
    }
    
    @IBAction func actionBtnAddcard(_ sender: UIButton) {
        if isChangeCard == true {
            self.objShoppingCartDelegates?.goToMyCards()
        } else {
            self.objShoppingCartDelegates?.goToAddCard()
        }
    }
    
    @IBAction func actionBtnToolTip(_ sender: UIButton) {
        self.configureCustomPopUp(AlertMessages.toolTipMessage, openIn: btnToolTip)
    }
    
    
    @IBAction func actionBtnCreditApply(_ sender: UIButton) {
        self.objShoppingCartDelegates?.goToApplyCredit()
    }
    
    @IBAction func actionBtnAvailableCredits(_ sender: UIButton) {
        self.objShoppingCartDelegates?.goToAvailableCredits()
    }
    
    
}

extension ShoppingCartProperties {
    
    func showDetails(_ request:TotalModelInfo?,etaTime:ExtrasETAModel?) {
        lblItemsTotalPrice.text =  "$\(CommonMethod.shared.convertToColombianPeso(amount: (request?.itemTotal ?? 0)) ?? "")"
        lblDeliveryFeePrice.text = "$\(CommonMethod.shared.convertToColombianPeso(amount: (request?.deliveryFee ?? 0)) ?? "")"
        lblTaxesAndChargePrice.text = "$\(CommonMethod.shared.convertToColombianPeso(amount: (request?.serviceFee ?? 0)) ?? "")"
        if !btnCreditApply.isSelected {
            lblcartTotalPrice.text = "$\(CommonMethod.shared.convertToColombianPeso(amount: (request?.cartTotal ?? 0)) ?? "")"
        }
        if request?.virtualCredits == 0 {
            vwWantToApplyCredit.isHidden = true
            cnstHeightVwWantToApply.constant = 0
            if !btnCreditApply.isSelected {
                lblAvailableCreditAmount.text = "$\(CommonMethod.shared.convertToColombianPeso(amount: (0.0)) ?? "")"
            }
        } else {
            vwWantToApplyCredit.isHidden = false
            cnstHeightVwWantToApply.constant = 80
            if !btnCreditApply.isSelected {
                lblAvailableCreditAmount.text = "$\(CommonMethod.shared.convertToColombianPeso(amount: (request?.virtualCredits ?? 0)) ?? "")"
            }
        }
        lblEstimatedTime.text = "\(etaTime?.eta ?? "")"
    }
    
    
//    func showAddressDetails() {
//        if primaryAddressSaved?.id ?? 0 == 0 {
//            vWNoDeliveryAddress.isHidden = false
//            isChangeAddress = false
//            vwBtnCheckout.alpha = 0.5
//            btnCheckout.isUserInteractionEnabled = false
//            btnAddAddress.setTitle("Add Address", for: .normal)
//        } else {
//            vWNoDeliveryAddress.isHidden = true
//            isChangeAddress = true
//            vwBtnCheckout.alpha = 1
//            btnCheckout.isUserInteractionEnabled = true
//            btnAddAddress.setTitle("Change Address", for: .normal)
//            lblShoppingAddress.text = primaryAddressSaved?.address ?? ""
//            lblAddressType.text = primaryAddressSaved?.type ?? ""
//        }
//        
//    }
    
    
    // MARK: Configure Custom PopUp Method
    func configureCustomPopUp(_ titleDes: String,openIn:UIButton) {
        popTip = Popover(options: popoverOptions)
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: 270, height: 120))
        let label = UILabel(frame: CGRect(x: 10, y: 5, width: 270 - 20, height: 120 - 10))
        label.numberOfLines = 0
        label.text = titleDes
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont(name: AppStyle.Fonts.interRegular, size: 14)!
        label.backgroundColor = .clear
        customView.addSubview(label)
        customView.backgroundColor = .white
        popTip.popoverColor = .white
        popTip.borderColorPopover = AppStyle.AppColors.appColorGreen
        popTip.cornerRadiusPopover = 12
        popTip.clipsToBounds = true
        popTip.show(customView, fromView: openIn)
    }
    
}
