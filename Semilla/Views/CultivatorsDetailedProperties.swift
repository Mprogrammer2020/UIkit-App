//
//  CultivatorsDetailedProperties.swift
//  Semilla
//
//  Created by netset on 13/12/23.
//

import UIKit

class CultivatorsDetailedProperties: UIView {
    
    
    //MARK: IBOutlet's
    @IBOutlet weak var lblCultivatorHeaderName: UILabel!
    @IBOutlet weak var imgVwCultivators: UIImageView!
    @IBOutlet weak var lblCultivatorsUserName: UILabel!
    @IBOutlet weak var lblCultivatorsRating: UILabel!
    @IBOutlet weak var lblOurProducts: UILabel!
    @IBOutlet weak var colVwOurProducts: UICollectionView!
//    @IBOutlet weak var cnstHeightColVwOurProducts: NSLayoutConstraint!
    @IBOutlet weak var vwNoItemFound: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var cnstBottomColVwOurProducts: NSLayoutConstraint!
    @IBOutlet weak var btnSeeAll: UIButton!
    
    //MARK: Variable Declaration
    var objCultivatorsDetailedDelegate: DelegatesCultivatorsDetailed?
    
    //MARK: IBAction's
    @IBAction func actionBtnBack(_ sender: UIButton) {
        self.objCultivatorsDetailedDelegate?.gotoBack()
    }
    
    
    @IBAction func actionBtnSeeAllOurProducts(_ sender: Any) {
        self.objCultivatorsDetailedDelegate?.gotoAllOurProducts()
    }
    
    func showCultivatorDetails(_ request:CultivatorList?) {
        imgVwCultivators.setImageOnImageViewServer(request?.imagePath ?? "", placeholder: UIImage(named: "ic_placeholder")!)
        lblCultivatorsUserName.text = "\(request?.firstName ?? "") \(request?.lastName ?? "")"
        lblCultivatorsRating.text = "\(request?.cultivator?.rating ?? 0)"
    }
    
    func showCultivatorDetailedFromItemDetailed(firstName:String, lastName:String, image:String, rating:Double) {
        lblCultivatorsUserName.text = "\(firstName) \(lastName)"
        imgVwCultivators.setImageOnImageViewServer(image, placeholder: UIImage(named: "ic_placeholder")!)
        lblCultivatorsRating.text = "\(rating)"
    }
    
    
}
