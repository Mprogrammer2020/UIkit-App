//
//  CategeoriesProperties.swift
//  Semilla
//
//  Created by Netset on 05/12/23.
//

import UIKit

class CategeoriesProperties: UIView {
    
    //MARK: IBOutlet's
    @IBOutlet weak var lblHearderCategeories: UILabel!
    @IBOutlet weak var txtFldSearch: UITextField!
    @IBOutlet weak var btnFilter: UIButton!
    @IBOutlet weak var colVwCategeories: UICollectionView!
    @IBOutlet weak var colVwCategeorieItems: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var cnstBottomColVwItem: NSLayoutConstraint!
    @IBOutlet weak var vwNoItemFound: UIView!
    @IBOutlet weak var lblCartCount: UILabel!
    @IBOutlet weak var vwCartCount: UIView!
    @IBOutlet weak var imgVwNotificationIcon: UIImageView!
    
    //MARK: Variable Declaration
    var objCategeoriesDelegate: DelegatesCategories?
    
    // MARK: View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.txtFldSearch.delegate = self
    }
    
    //MARK: IBAction's
    @IBAction func actionBtnNotifi(_ sender: UIButton) {
        self.objCategeoriesDelegate?.goToNotifi()
    }
    
    @IBAction func actionBtnShoppingcart(_ sender: UIButton) {
        self.objCategeoriesDelegate?.goToShoppingCart()
    }
    
    @IBAction func actionBtnFilter(_ sender: UIButton) {
        self.objCategeoriesDelegate?.gotoFilter()
    }
    
}

// MARK: UITextField Delegate Method
extension CategeoriesProperties: UITextFieldDelegate {
    
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
        objCategeoriesDelegate?.handleSearchData(textField.text ?? "")
    }
    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        objCategeoriesDelegate?.handleSearchData(textField.text ?? "")
//    }
    
}
