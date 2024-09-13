//
//  SearchHistoryProperties.swift
//  Semilla
//
//  Created by Netset on 21/12/23.
//

import UIKit

class SearchHistoryProperties: UIView {
    
    //MARK: IBOutlet's
    @IBOutlet weak var lblHeaderSearchHistory: UILabel!
    @IBOutlet weak var txtFldSearch: UITextField!
    @IBOutlet weak var colVwSearchCategeories: UICollectionView!
    @IBOutlet weak var colVwSearchItems: UICollectionView!
    @IBOutlet weak var vwNoItemFound: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var cnstBottomColVwSearchItems: NSLayoutConstraint!
    
    //MARK: Variable Declaration
    var objSearchHistoryDelegate: DelegatesSearchHistory?
    
    // MARK: View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.txtFldSearch.becomeFirstResponder()
        self.txtFldSearch.delegate = self
    }
    
    //MARK: IBAction's
    @IBAction func actionBtnBack(_ sender: UIButton) {
        self.objSearchHistoryDelegate?.gotoBack()
    }
    
    @IBAction func actionBtnFilter(_ sender: UIButton) {
        self.objSearchHistoryDelegate?.goToFilter()
    }
    
}


extension SearchHistoryProperties: UITextFieldDelegate {
    
    // MARK: UITextField Delegate Method
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
        objSearchHistoryDelegate?.handleSearchData(textField.text ?? "")
    }
    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        objSearchHistoryDelegate?.handleSearchData(textField.text ?? "")
//    }
    
    
}
