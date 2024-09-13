//
//  NotificationsDelegate+Datas.swift
//  Semilla
//
//  Created by netset on 13/12/23.
//

import UIKit

class NotificationsDatasources: NSObject,UITableViewDataSource {
    
    //MARK: Variable Declaration
    private var viewModel: NotificationsVM!
    private var notifications: NotificationsProperties!
    
    //MARK: Intialization
    init(viewModel: NotificationsVM!, notifications: NotificationsProperties!) {
        self.viewModel = viewModel
        self.notifications = notifications
    }
    
    //MARK: TableView Datasource Method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.arrNotificationsList.count == 0 {
            notifications.vwNoNotificationFound.isHidden = false
        } else {
            notifications.vwNoNotificationFound.isHidden = true
            return viewModel.arrNotificationsList.count
        }
        return viewModel.arrNotificationsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = viewModel.arrNotificationsList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCells.notificationListTVC, for: indexPath) as! NotificationListTVC
        if data.title == ValidationMessages.OA {
            cell.imgVwUsers.image = UIImage(named: "ic_Shoppingbag")
        } else  if data.title == ValidationMessages.OP {
            cell.imgVwUsers.image = UIImage(named: "ic_Shoppingbag")
        } else if data.title == ValidationMessages.OFD {
            cell.imgVwUsers.image = UIImage(named: "ic_Delivery")
        } else if data.title == ValidationMessages.OD {
            cell.imgVwUsers.image = UIImage(named: "ic_Delivered")
        } else if data.title == ValidationMessages.DPA {
            cell.imgVwUsers.image = UIImage(named: "ic_Delivery")
        }  else if data.title == ValidationMessages.OC {
            cell.imgVwUsers.image = UIImage(named: "ic_OrderCancel")
        } else if data.title == ValidationMessages.OR {
            cell.imgVwUsers.image = UIImage(named: "ic_OrderCancel")
        } else if data.title == ValidationMessages.ADL {
            cell.imgVwUsers.image = UIImage(named: "ic_Delivery")
        } else if data.title == ValidationMessages.virtualCredits {
            cell.imgVwUsers.image = UIImage(named: "ic_Notifi_Credit")
        } else {
            cell.imgVwUsers.image = UIImage(named: "ic_Shoppingbag")
        }
        cell.lblUsername.text = data.title
        cell.lblNotificationText.text = data.description
        let timeStr = "\(UTCToLocal(data.time ?? "", backendFormat: DateFormats.UTCFormat1, needFormat: DateFormats.YYYYMMDDHHMMSS))"
        let date = CommonMethod.shared.getDateFromSting(string: timeStr, stringFormat: DateFormats.YYYYMMDDHHMMSS)
        cell.lblNotificationTime.text = date.getElapsedInterval()
        return cell
    }
}

//MARK: TableView Delegate Method
class NotificationsDelegate: NSObject, UITableViewDelegate, UIScrollViewDelegate {
    
    //MARK: Variable Declaration
    private var viewModel: NotificationsVM!
    private var notifications: NotificationsProperties!
    var callBackToNavigate:((Int)->())?
    
    
    //MARK: Intialization
    init(viewModel: NotificationsVM!, notifications: NotificationsProperties!) {
        self.viewModel = viewModel
        self.notifications = notifications
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.callBackToNavigate?(indexPath.row)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == notifications.tblVwNotificationList {
            if ((self.notifications.tblVwNotificationList.contentOffset.y + self.notifications.tblVwNotificationList.frame.size.height) >= self.notifications.tblVwNotificationList.contentSize.height) {
                if (self.viewModel.pageNumber + 1)<(self.viewModel.totalPages) {
                    let currentPage = (self.viewModel.pageNumber )
                    self.viewModel.pageNumber =  currentPage + 1
                    let activityIndicator = UIActivityIndicatorView()
                    notifications.tblVwNotificationList.tableFooterView = activityIndicator
                    notifications.tblVwNotificationList.tableFooterView?.isHidden = false
                    viewModel.notificationsApiMethod(false) {
                        self.notifications.tblVwNotificationList.tableFooterView?.isHidden = true
                        self.notifications.tblVwNotificationList.reloadData()
                    }
                }
            }
        }
    }
    
    
}
