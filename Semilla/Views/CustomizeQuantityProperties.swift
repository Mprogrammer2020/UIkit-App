//
//  CustomizeQuantityProperties.swift
//  Semilla
//
//  Created by netset on 12/12/23.
//

import UIKit

class CustomizeQuantityProperties: UIView {
    
    //MARK: IBOutlet's
    @IBOutlet weak var txtFldSelectUnit: CustomUITextField!
    @IBOutlet weak var btnArrowDownSelectUnit: UIButton!
    @IBOutlet weak var btnOk: UIButton!
    @IBOutlet weak var vwBtnOk: Gradient!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var vwbtnIncrease: UIView!
    @IBOutlet weak var btnIncrease: UIButton!
    @IBOutlet weak var vwbtnDecrease: UIView!
    @IBOutlet weak var btnDecrease: UIButton!
    
    //MARK: Variable Declaration
    var objCustomizeQuantityDelegates: DelegatesCustomizeQuantity?
    var pickerViewType = UIPickerView()
    var arrQuantity = [ProductInfo]()
    var objViewModelx = CustomizeQuantityVM()
    var number = Int()
    
    // MARK: View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        txtFldSelectUnit.tintColor = .clear
    }
    
    //MARK: IBAction's
    @IBAction func actionbtnArrowDownSelectUnit(_ sender: UIButton) {
        //isUserInteractionEnabled = false
    }
    
    @IBAction func actionBtnOk(_ sender: UIButton) {
        self.objCustomizeQuantityDelegates?.callApiAddItemToCart()
    }
    
    @IBAction func actionBtnClose(_ sender: UIButton) {
        self.objCustomizeQuantityDelegates?.gotoBack()
    }
    
    @IBAction func actionBtnDecreaseCount(_ sender: UIButton) {
        if number > 1 {
            number = number - 1
            updateLabel()
            vwbtnIncrease.alpha = 1
            btnIncrease.isUserInteractionEnabled = true
        }
    }
    
    @IBAction func actionBtnIncreaseCount(_ sender: UIButton) {
//        if (objViewModelx.quantity?.availableStock ?? 0) > number {
//            number = number + 1
//            updateLabel()
//            if number == (objViewModelx.quantity?.availableStock ?? 0) {
//                vwbtnIncrease.alpha = 0.5
//                btnIncrease.isUserInteractionEnabled = false
//            } else {
//                vwbtnIncrease.alpha = 1
//                btnIncrease.isUserInteractionEnabled = true
//            }
//        }
    }
    
    func updateLabel() {
        lblCount.text = "\(number)"
    }
    
    func getDetail(_ detail: [ProductInfo],viewModel:CustomizeQuantityVM) {
        arrQuantity = detail
        objViewModelx = viewModel
        updateLabel()
    }
}


extension CustomizeQuantityProperties: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrQuantity.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let availableStock = ((arrQuantity[row].availableStock ?? 0))
        let quantityValue = (arrQuantity[row].packaging ?? 0)
        let formatStr = NSMutableAttributedString()
        let formatStr1 = NSMutableAttributedString()
        if availableStock == 0 {
            formatStr.attributedString("\(quantityValue)\(arrQuantity[row].unit?.unit ?? "")", color: UIColor.black, font: appFont(name: AppStyle.Fonts.interMedium, size: 8), lineHeight: 1.2, align: TextAlign.left).attributedString(" \(AlertMessages.outOfStock)", color: UIColor.red, font: appFont(name: AppStyle.Fonts.interMedium, size: 8), lineHeight: 1.2, align: TextAlign.left)
            formatStr1.attributedString("\(quantityValue)\(arrQuantity[row].unit?.unit ?? "")", color: UIColor.black, font: appFont(name: AppStyle.Fonts.interMedium, size: 8), lineHeight: 1.2, align: TextAlign.center).attributedString(" \(AlertMessages.outOfStock)", color: UIColor.red, font: appFont(name: AppStyle.Fonts.interMedium, size: 8), lineHeight: 1.2, align: TextAlign.left)
        } else {
            formatStr.attributedString("\(quantityValue)\(arrQuantity[row].unit?.unit ?? "")", color: UIColor.black, font: appFont(name: AppStyle.Fonts.interMedium, size: 8), lineHeight: 1.2, align: TextAlign.left)
            formatStr1.attributedString("\(quantityValue)\(arrQuantity[row].unit?.unit ?? "")", color: UIColor.black, font: appFont(name: AppStyle.Fonts.interMedium, size: 8), lineHeight: 1.2, align: TextAlign.center)
        }
        txtFldSelectUnit.attributedText = formatStr
        return formatStr1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let availableStock = ((arrQuantity[row].availableStock ?? 0))
        let quantityValue = (arrQuantity[row].packaging ?? 0)
        let formatStr = NSMutableAttributedString()
        if availableStock == 0 {
            formatStr.attributedString("\(quantityValue)\(arrQuantity[row].unit?.unit ?? "")", color: UIColor.black, font: appFont(name: AppStyle.Fonts.interMedium, size: 8), lineHeight: 1.2, align: TextAlign.left).attributedString(" \(AlertMessages.outOfStock)", color: UIColor.red, font: appFont(name: AppStyle.Fonts.interMedium, size: 8), lineHeight: 1.2, align: TextAlign.left)
            vwBtnOk.alpha = 0.5
            btnOk.isUserInteractionEnabled = false
        } else {
            formatStr.attributedString("\(quantityValue)\(arrQuantity[row].unit?.unit ?? "")", color: UIColor.black, font: appFont(name: AppStyle.Fonts.interMedium, size: 8), lineHeight: 1.2, align: TextAlign.left)
            vwBtnOk.alpha = 1
            btnOk.isUserInteractionEnabled = true
            vwbtnIncrease.alpha = 1
            btnIncrease.isUserInteractionEnabled = true
        }
//        objViewModelx.quantity = arrQuantity[row]
//        number = (objViewModelx.quantity?.cartQuantity ?? 0)
        if availableStock == 0 {
            self.number = 0
        } else {
            if self.number == 0 {
                self.number = 1
            }
        }
        updateLabel()
        txtFldSelectUnit.attributedText = formatStr
    }
    
}

extension CustomizeQuantityProperties: UITextFieldDelegate {
 
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        txtFldSelectUnit.inputView = pickerViewType
        pickerViewType.dataSource = self
        pickerViewType.delegate = self
        pickerViewType.reloadAllComponents()
        return true
    }
    
}
