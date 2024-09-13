//
//  CustomerReviewsTVC.swift
//  Semilla
//
//  Created by Netset on 25/01/24.
//

import UIKit

class CustomerReviewsTVC: UITableViewCell,Reusable {

    //MARK: IBOutlet's
    @IBOutlet weak var imgVwDriverImage: UIImageView!
    @IBOutlet weak var lblDriverName: UILabel!
    @IBOutlet weak var lblDriverReviewTime: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var vwRatingStars: FloatRatingView!
    @IBOutlet weak var lblReviewComment: UILabel!
    
    //MARK: Viewlife Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
