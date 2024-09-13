//
//  ShoopingCartTVC.swift
//  Semilla
//
//  Created by Netset on 05/12/23.
//

import UIKit

class ShoopingCartTVC: UITableViewCell {
    
    
    //MARK: IBOutlet's
    @IBOutlet weak var imgVwItem: UIImageView!
    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var lblItemCategeoryQty: UILabel!
    @IBOutlet weak var lblItemPrice: UILabel!
    @IBOutlet weak var lblItemDiscountPrice: UILabel!
    @IBOutlet weak var lblQtyNumber: UILabel!
    @IBOutlet weak var btnIncreaseQty: UIButton!
    @IBOutlet weak var btnDecreaseQty: UIButton!
    @IBOutlet weak var vwDiscountLine: UIView!
    @IBOutlet weak var vwBtnQtyDecrease: UIView!
    @IBOutlet weak var vwBtnQtyIncrease: UIView!
    @IBOutlet weak var lblOutOfStock: UILabel!
    
    
    //MARK: Viewlife Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: IBAction's
    @IBAction func actionbtnIncreaseQty(_ sender: UIButton) {
    }
    
    @IBAction func actionbtnDecreaseQty(_ sender: UIButton) {
    }
    
    
}
