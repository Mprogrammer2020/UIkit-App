//
//  SeeAllRecentlyItemsProperties.swift
//  Semilla
//
//  Created by Inder Sandhu on 16/12/23.
//

import UIKit

class SeeAllRecentlyItemsProperties: UIView {

//MARK: IBOutlet's
    @IBOutlet weak var lblHeaderSeeAllRecentlyItems: UILabel!
    @IBOutlet weak var colVwRecentlyItems: UICollectionView!
    @IBOutlet weak var txtFldSearchItems: UITextField!
    @IBOutlet weak var colVwCategeories: UICollectionView!
    @IBOutlet weak var vwNoItemFound: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var cnstBottomColVwRecentlyListed: NSLayoutConstraint!
    
    //MARK: Variable Declaration
    var objSeeAllDelegates: DelegatesSeeAllRecentlyItem?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.txtFldSearchItems.delegate = self
    }
    
    //MARK: IBAction's
    @IBAction func actionBtnBack(_ sender: UIButton) {
        self.objSeeAllDelegates?.gotoBack()
    }
    
    
    @IBAction func actionBtnFilterData(_ sender: UIButton) {
        self.objSeeAllDelegates?.goToFilterData()
    }
    
}


// MARK: UITextField Delegate Method
extension SeeAllRecentlyItemsProperties: UITextFieldDelegate {
    
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
        objSeeAllDelegates?.handleSearchData(textField.text ?? "")
    }
    
}
