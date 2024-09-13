//
//  HelpAndSupportProperties.swift
//  Semilla
//
//  Created by Netset on 19/12/23.
//

import UIKit
import IQKeyboardManagerSwift

class HelpAndSupportProperties: UIView {
    
    //MARK: IBOutlet's
    @IBOutlet weak var lblHelpAndSupport: UILabel!
    @IBOutlet weak var lblContactUs: UILabel!
    @IBOutlet weak var imgVwHelpAndSupport: UIImageView!
    @IBOutlet weak var lblSupportSolutions: UILabel!
    @IBOutlet weak var txtVwMessage: IQTextView!
    @IBOutlet weak var txtFldEmail: UITextField!
    @IBOutlet weak var txtFldFullName: UITextField!
    
    //MARK: Variable Declaration
    var objHelpAndSupportDelegates:DelegatesHelpAndSupport?
    
    // MARK: View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        txtVwMessage.placeholder = "\(ValidationMessages.enterYourMessage)"
    }
    
    //MARK: IBAction's
    @IBAction func actionBtnBack(_ sender: UIButton) {
        self.objHelpAndSupportDelegates?.gotoBack()
    }
    
    @IBAction func actionBtnSendMessage(_ sender: Any) {
        let request = HelpAndSupoortRequest(email: txtFldEmail.text ?? "", fullName: txtFldFullName.text ?? "", message: txtVwMessage.text ?? "")
            self.objHelpAndSupportDelegates?.goToMessageSent(request)
    }
    
    @IBAction func actionBtnCancel(_ sender: Any) {
        self.txtFldFullName.text = ""
        self.txtFldEmail.text = ""
        self.txtVwMessage.text = ""
    }
    
    func showData() {
        self.txtFldFullName.text = "\(loginUserDetail?.firstName ?? "") \(loginUserDetail?.lastName ?? "")"
    }
    
}

//MARK: UI Textfield Delegate
extension HelpAndSupportProperties: UITextFieldDelegate {
    
    // MARK: UITextField Delegate Method
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtFldEmail {
            txtFldEmail.goToNextTextFeild(nextTextFeild: txtFldFullName)
        }else if textField == txtFldFullName {
            //txtFldFullName.resignFirstResponder()
            txtVwMessage.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == " " && range.location == 0 {
            return false
        }
//        
//        if (textField == txtFldFullName) {
//            return false
//        }
//        
//        if (textField == txtFldEmail)  {
//            return false
//        }
        
        if textField == txtFldFullName {
            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            return updatedText.count <= 30
        } else {
            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            return updatedText.count <= 30
        }
    }
}

extension HelpAndSupportProperties: UITextViewDelegate  {
    
    // MARK: Text View Delegate Method
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let _char = text.cString(using: String.Encoding.utf8)
        let isBackSpace: Int = Int(strcmp(_char, "\\b"))
        if isBackSpace == -92 {
            return true
        }
        if (textView.text?.count == 0 && text == " ") || (textView.text?.count == 0 && text == "\n") {
            return false
        }
        if (range.location == 0 && text == " ") {
            return false
        }
        if textView.text.count > 490 {
            return false
        }
        return true
    }
    
}
