//
//  AddCardProperties.swift
//  Semilla
//
//  Created by netset on 13/12/23.
//

import UIKit
import Stripe

class AddCardProperties: UIView {
    
    //MARK: IBOutlet's
    @IBOutlet weak var lblCreditDebitCard: UILabel!
    @IBOutlet weak var lblEnterDetailsCard: UILabel!
    @IBOutlet weak var ImgVwCard: UIImageView!
    @IBOutlet weak var txtFldAddCardNumber: UITextField!
    @IBOutlet weak var txtFldAddCardName: UITextField!
    @IBOutlet weak var txtFldAddCVV: CustomUITextField!
    @IBOutlet weak var txtFldAddExpiryDate: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var getImgVwCard: UIImageView!
    
    
    //MARK: Variable Declaration
    var objAddCardDelegates: DelegatesAddCard?
    var selectOrderStatus = String()
    var selectedMonth = Int()
    var selectedYear = Int()
    var cardName = String()
    var arrCardType = [("American Express",selectedType.amex),("Codensa",selectedType.codensa),("Dinners Club",selectedType.diners),("Master Card",selectedType.mastercard)/*,("Master Card (Debit)",selectedType.masterCardDebit)*/,("Visa Card",selectedType.visa)/*,("Visa Card (Debit)",selectedType.visaDebit)*/]
    var pickerVw = UIPickerView()
    
    // MARK: View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        addCardMethod()
        prepareUI()
//        txtCards.addTarget(self, action: #selector(didChangeCardNo(_:)), for: .editingChanged)
    }
    
    //MARK: Custom Declaration
    func prepareUI() {
        self.txtFldAddCardName.delegate = self
        self.txtFldAddCardNumber.delegate = self
        self.txtFldAddCVV.delegate = self
        self.txtFldAddExpiryDate.delegate = self
    }
    
    
    //MARK: IBAction's
    @IBAction func actionBtnBack(_ sender: UIButton) {
        self.objAddCardDelegates?.gotoBack()
    }
    
    @IBAction func actionBtnSave(_ sender: UIButton) {
        let request = AddCardRequest(cardNo: (txtFldAddCardNumber.text ?? "").removeWhiteSpace(),cardUserName: txtFldAddCardName.text ?? "",cardCvv: selectOrderStatus,cardExpDate: txtFldAddExpiryDate.text ?? "", cardYear: selectedYear, cardMonth: selectedMonth)
        debugPrint((txtFldAddCardNumber.text ?? "").removeWhiteSpace())
            self.objAddCardDelegates?.callApiAddCard(request)
    }
    
    @IBAction func actionBtnCancel(_ sender: UIButton) {
    }
    
}

extension AddCardProperties: UITextFieldDelegate {
    
    // MARK: UITextField Delegate Method
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtFldAddCardNumber {
            txtFldAddCardNumber.goToNextTextFeild(nextTextFeild: txtFldAddCardName)
        } else if textField == txtFldAddCVV {
            txtFldAddCVV.goToNextTextFeild(nextTextFeild: txtFldAddExpiryDate)
        } else if textField == txtFldAddCardName {
            txtFldAddCardName.goToNextTextFeild(nextTextFeild: txtFldAddCVV)
        } else if textField == txtFldAddExpiryDate{
            txtFldAddExpiryDate.resignFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == " " && range.location == 0 {
            return false
        }
         if textField == txtFldAddCardNumber {
            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            return updatedText.count <= 19
        } else if textField == txtFldAddCVV {
            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            return updatedText.count <= 4
        } else if textField == txtFldAddCardName {
            let allowedCharacterSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ")
            let replacementStringCharacterSet = CharacterSet(charactersIn: string)
            if !allowedCharacterSet.isSuperset(of: replacementStringCharacterSet) {
                return false
            }
            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            return updatedText.count <= 30
        }
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtFldAddExpiryDate {
            self.objAddCardDelegates?.gotoCalendar()
            return false
        } else if textField == txtFldAddCVV {
            txtFldAddCVV.inputView = pickerVw
            pickerVw.dataSource = self
            pickerVw.delegate = self
            pickerVw.reloadAllComponents()
            return true
        }
        return true
    }
}

extension AddCardProperties {
    
    func addCardMethod() {
        txtFldAddCardNumber.addTarget(self, action: #selector(didChangeCardNo(_:)), for: .editingChanged)
    }
    
    func modifyCreditCardString(creditCardString : String) -> String {
        let trimmedString = creditCardString.components(separatedBy: .whitespaces).joined()
        let arrOfCharacters = Array(trimmedString)
        var modifiedCreditCardString = ""
        if(arrOfCharacters.count > 0) {
            for i in 0...arrOfCharacters.count-1 {
                modifiedCreditCardString.append(arrOfCharacters[i])
                if((i+1) % 4 == 0 && i+1 != arrOfCharacters.count){
                    modifiedCreditCardString.append(" ")
                }
            }
        }
        return modifiedCreditCardString
    }
    
    @objc func didChangeCardNo(_ textField:UITextField) {
        textField.text = self.modifyCreditCardString(creditCardString: textField.text!)
        //        lblCardNo.text = textField.text ?? ""
        if let detectedType = CreditCardType.detect(textField.text!) {
            print("Detected card type: \(detectedType.name)")
            print("Image resource name: \(detectedType.imageResourceName)")
            getImgVwCard.image = UIImage(named: detectedType.imageResourceName)
        }
        if textField.isBlank {
            getImgVwCard.image = UIImage(named: "cardPlaceholder")
        }
        
        //
        //        let getImg = (cardBrand.lowercased()).getCardImage
        //        getImgVwCard.image = getImg.0
        //        cardName = getImg.1
        //        if (textField.text ?? "") == "" {
        //            lblCardNo.text = "XXXX XXXX XXXX XXXX"
        //        }
    }
}
extension AddCardProperties: UIPickerViewDataSource , UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrCardType.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        txtFldAddCVV.text = arrCardType[row].0
        selectOrderStatus = arrCardType[row].1
        return arrCardType[row].0
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txtFldAddCVV.text = arrCardType[row].0
        selectOrderStatus = arrCardType[row].1
    }
}
