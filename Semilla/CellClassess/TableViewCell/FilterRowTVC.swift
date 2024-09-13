//
//  FilterRowTVC.swift
//  Semilla
//
//  Created by netset on 07/12/23.
//

import UIKit

class FilterRowTVC: UITableViewCell {

    
    //MARK: IBOutlet's
    @IBOutlet weak var lblItemsName: UILabel!
    @IBOutlet weak var btnCheckbox: UIButton!
    @IBOutlet weak var vwRating: FloatRatingView!
    
    //MARK: Viewlife Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    //MARK: IBAction's
    @IBAction func actionBtnCheckbox(_ sender: Any) {
    }
}
