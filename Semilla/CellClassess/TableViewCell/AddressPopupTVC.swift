//
//  AddressPopupTVC.swift
//  Semilla
//
//  Created by Netset on 22/03/24.
//

import UIKit

class AddressPopupTVC: UITableViewCell {

    //MARK: IBOutlet's
    @IBOutlet weak var lblAddressType: UILabel!
    @IBOutlet weak var lblAddressName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var btnSelectAddress: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    //MARK: IBAction's
    @IBAction func actionBtnSelectAddress(_ sender: UIButton) {
        
    }
    

}
