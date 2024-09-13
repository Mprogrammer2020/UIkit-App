//
//  AddresseslistTVC.swift
//  Semilla
//
//  Created by netset on 11/12/23.
//

import UIKit

class AddresseslistTVC: UITableViewCell {

    //MARK: IBOutlet's
    @IBOutlet weak var lblAddressType: UILabel!
    @IBOutlet weak var btnDeleteAddress: UIButton!
    @IBOutlet weak var btnEditAddress: UIButton!
    @IBOutlet weak var lblFullAddress: UILabel!
    @IBOutlet weak var btnSelectAddress: UIButton!
    @IBOutlet weak var lblUserAddressName: UILabel!
    
    //MARK: Variable Declaration
    
    //MARK: Viewlife Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
                
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    //MARK: IBAction's
    @IBAction func actionBtnEditAddress(_ sender: UIButton) {
    }
    
    @IBAction func actionBtnDeleteAddress(_ sender: UIButton) {
    }
    
    @IBAction func actionBtnSelectAddress(_ sender: UIButton) {
    }
    
}
