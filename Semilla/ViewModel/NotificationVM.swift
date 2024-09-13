//
//  NotificationVM.swift
//  Semilla
//
//  Created by netset on 13/12/23.
//

import Foundation


class NotificationsVM {
    
    var pageNumber = 0
    var pageSize = 10
    var totalPages = Int()
    var arrNotificationsList = [NotificationsList]()
    
    var myNotifications = [
        NotificationModel(userImage: "ic_Shoppingbag",userName: "Order Accepted",notificationMessage: "Your order with \("order id") has been accepted successfully.",notificationsTime: "2h"),
        NotificationModel(userImage: "ic_Delivery",userName: "Out for Delivery",notificationMessage: "Your order with #74573 is now out for delivery.",notificationsTime: "3h"),
        NotificationModel(userImage: "ic_Delivered",userName: "Order Delivered",notificationMessage: "Your order with \("order id") has been delivered successfully.",notificationsTime: "6h"),
    ]
    
    func notificationsApiMethod(_ isShowIndicator: Bool,completion:@escaping() -> Void) {
        WebServices.shared.getData("\(ApiUrl.notifications)/page/\(pageNumber)/size/\(pageSize)", showIndicator: isShowIndicator) { (response) in
            if self.pageNumber == 0 {
                self.arrNotificationsList.removeAll()
            }
            if response.isSuccess {
                let apiData = Constants.shared.jsonDecoder.decode(model: NotificationsModel.self, data: response.data)!
                if self.pageNumber == 0 {
                    self.arrNotificationsList.removeAll()
                    self.arrNotificationsList = apiData.data?.list ?? []
                } else {
                    self.arrNotificationsList = self.arrNotificationsList + (apiData.data?.list ?? [])
                }
                let plusVal = ((apiData.data?.total ?? 0) % self.pageSize) == 0 ? 0 : 1
                self.totalPages = ((apiData.data?.total ?? 0) / self.pageSize) + plusVal
                debugPrint("self.totalPages",self.totalPages)
            }
            completion()
        }
    }
    
}
