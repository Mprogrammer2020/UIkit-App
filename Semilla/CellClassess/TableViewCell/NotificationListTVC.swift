//
//  NotificationListTVC.swift
//  Semilla
//
//  Created by netset on 11/12/23.
//

import UIKit

class NotificationListTVC: UITableViewCell {

    //MARK: IBOutlet's
    @IBOutlet weak var imgVwUsers: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblNotificationText: UILabel!
    @IBOutlet weak var lblNotificationTime: UILabel!
    
    //MARK: Viewlife Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
