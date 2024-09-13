//
//  NotificationsProperties.swift
//  Semilla
//
//  Created by netset on 11/12/23.
//

import UIKit


class NotificationsProperties: UIView {

    //MARK: IBOutlet's
    @IBOutlet weak var lblHeaderNotifications: UILabel!
    @IBOutlet weak var tblVwNotificationList: UITableView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var vwNoNotificationFound: UIView!
    
    //MARK: Variable Declaration
    var objNotificationDelegates: DelegatesNotification?
    
    //MARK: IBAction's
    @IBAction func actionBtnBack(_ sender: UIButton) {
        self.objNotificationDelegates?.gotoBack()
    }

}
