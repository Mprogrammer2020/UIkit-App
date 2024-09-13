//
//  UITextFieldClass.swift
//  UInOne
//
//  Created by netset on 27/05/24.
//

import Foundation

import UIKit

class CustomUITextField: UITextField {
   override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {

       if action == #selector(UIResponderStandardEditActions.cut(_:)) || action == #selector(UIResponderStandardEditActions.copy(_:)) || action == #selector(UIResponderStandardEditActions.paste(_:)) || action == #selector(UIResponderStandardEditActions.select(_:)) || action == #selector(UIResponderStandardEditActions.selectAll(_:)){
           return false
       }
       
        return super.canPerformAction(action, withSender: sender)
   }
}
