//
//  CultivatorProperties.swift
//  Semilla
//
//  Created by Netset on 05/12/23.
//

import UIKit

class CultivatorProperties: UIView {
    
    //MARK: IBOutlet's
    @IBOutlet weak var lblHeaderCultivator: UILabel!
    @IBOutlet weak var colVwUserList: UICollectionView!
    @IBOutlet weak var vwHeaderName: UIView!
    @IBOutlet weak var vwSearchBar: UIView!
    @IBOutlet weak var txtFieldSearch: UITextField!
    @IBOutlet weak var lblCartCount: UILabel!
    @IBOutlet weak var vwCartCount: UIView!
    @IBOutlet weak var vwNoCultivatorFound: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var cnstBottomColVwItem: NSLayoutConstraint!
    @IBOutlet weak var imgVwNotificationIcon: UIImageView!
    
    //MARK: Variable Declaration
    var objCultivatorDelegate: DelegatesCultivator?
    var userNameWorkItemReference: DispatchWorkItem? = nil
    
    // MARK: View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.txtFieldSearch.delegate = self
        activityIndicator.isHidden = true
    }
    //MARK: IBAction's
    @IBAction func actionBtnFilter(_ sender: UIButton) {
        self.objCultivatorDelegate?.goToFilter()
    }
    
    @IBAction func actionBtnNotification(_ sender: UIButton) {
        self.objCultivatorDelegate?.goToNotifications()
    }
    
    @IBAction func actionBtnShoppingCart(_ sender: UIButton) {
        self.objCultivatorDelegate?.goToShoppingCart()
    }
}

// MARK: UITextField Delegate Method
extension CultivatorProperties: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == " " && range.location == 0 {
            return false
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        userNameWorkItemReference?.cancel()
        let userNameWorkItem = DispatchWorkItem { [weak self] in
            self?.objCultivatorDelegate?.handleSearchData(textField.text ?? "")
        }
        userNameWorkItemReference = userNameWorkItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: userNameWorkItem)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        objCultivatorDelegate?.handleSearchData(textField.text ?? "")
    }    
    
}
