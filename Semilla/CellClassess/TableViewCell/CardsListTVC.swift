//
//  CardsListTVC.swift
//  Semilla
//
//  Created by netset on 13/12/23.
//

import UIKit

class CardsListTVC: UITableViewCell {

    
    //MARK: IBOutlet's
    @IBOutlet weak var btnCardSelect: UIButton!
    @IBOutlet weak var lblCardsUsername: UILabel!
    @IBOutlet weak var btnMarkAsPrimary: UIButton!
    @IBOutlet weak var lblCardsLastFourDigits: UILabel!
    @IBOutlet weak var imgVwCardsType: UIImageView!
    @IBOutlet weak var lblCardsExpiryDate: UILabel!
    @IBOutlet weak var btnCardsDelete: UIButton!
    @IBOutlet weak var cnstCardImgVwTop: NSLayoutConstraint!
    
    
    //MARK: Viewlife Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    //MARK: IBAction's
    @IBAction func actionBtnCardSelect(_ sender: UIButton) {
    }
    
    @IBAction func actionBtnMarkAsPrimary(_ sender: UIButton) {
    }
    
    @IBAction func actionBtnCardsDelete(_ sender: UIButton) {
    }
    
}
