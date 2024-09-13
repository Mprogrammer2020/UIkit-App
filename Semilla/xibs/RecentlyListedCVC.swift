//
//  RecentlyListedCVC.swift
//  Semilla
//
//  Created by Netset on 30/11/23.
//

import UIKit

class RecentlyListedCVC: UICollectionViewCell {

    
    //MARK: IBOutlet's
    @IBOutlet weak var imgVwItems: UIImageView!
    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var lblItemPrice: UILabel!
    @IBOutlet weak var lblItemWeight: UILabel!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var vwIncrementAndDecrementItem: UIView!
    @IBOutlet weak var vwBtnAddItem: UIView!
    @IBOutlet weak var btnIncreaceItem: UIButton!
    @IBOutlet weak var btnDereaseItem: UIButton!
    @IBOutlet weak var lblItemCount: UILabel!
    @IBOutlet weak var lblCostPerGram: UILabel!
    
    //MARK: Viewlife Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: IBAction's
    @IBAction func actionBtnAdd(_ sender: UIButton) {
    }
    
    @IBAction func actionBtnIncreaseItemCount(_ sender: UIButton) {
    }
    
    @IBAction func actionBtnDecreaseItemCount(_ sender: UIButton) {
    }
    
}
