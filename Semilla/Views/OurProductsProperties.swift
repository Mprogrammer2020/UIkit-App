//
//  OurProductsProperties.swift
//  Semilla
//
//  Created by Netset on 26/12/23.
//

import UIKit

class OurProductsProperties: UIView {
    
    //MARK: IBOutlet's
    @IBOutlet weak var lblHeaderOurProducts: UILabel!
    @IBOutlet weak var colVwAllOurProducts: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var vwNoItemsFound: UIView!
    @IBOutlet weak var cnstBottomColVwOurProducts: NSLayoutConstraint!
    
    //MARK: Variable Declarations
    var objOurProductsDelegate: DelegatesOurProducts?
    
    //MARK: IBAction's
    @IBAction func actionBtnBack(_ sender: UIButton) {
        self.objOurProductsDelegate?.gotoBack()
    }
    
}
