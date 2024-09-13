//
//  SeeAllCultivatorProperties.swift
//  Semilla
//
//  Created by Inder Sandhu on 18/12/23.
//

import UIKit

class SeeAllCultivatorProperties: UIView {

    //MARK: IBOutlet's
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var colVwCutivatorsList: UICollectionView!
    @IBOutlet weak var lblHeaderCultivators: UILabel!
    @IBOutlet weak var cnstColVwBottom: NSLayoutConstraint!
    
    //MARK: Variable Declaration
    var objSeeAllCultivatorDelegates: DelegatesSeeAllCutivator?
    
//MARK: IBAction's
    @IBAction func actionBtnBack(_ sender: UIButton) {
        self.objSeeAllCultivatorDelegates?.gotoBack()
    }
    
    
}
