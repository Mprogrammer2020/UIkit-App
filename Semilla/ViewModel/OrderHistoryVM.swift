//
//  OrderHistoryVM.swift
//  Semilla
//
//  Created by netset on 13/12/23.
//

import UIKit

class OrderHistoryVM {
    
    var btnClicks = NSMutableArray()
    var pageNumber = 0
    var pageSize = 10
    var totalPages = Int()
    var arrOrderHistory = [OrdersList]()
    let refreshControl = UIRefreshControl()
    
    func orderHistoryApiMethod(_ isLoader:Bool, completion:@escaping() -> Void) {
        let param = [
            AppParam.cultivatorList.page: "\(pageNumber)",
            AppParam.cultivatorList.size: "\(pageSize)"
        ]
        WebServices.shared.postData(ApiUrl.orderHistory, params: param, showIndicator: isLoader, methodType: .post, completion: { response in
            if self.pageNumber == 0 {
                self.arrOrderHistory.removeAll()
            }
            if response.isSuccess {
                self.refreshControl.endRefreshing()
                let apiData = Constants.shared.jsonDecoder.decode(model: OrderHistoryModel.self, data: response.data)!
                if self.pageNumber == 0 {
                    self.arrOrderHistory.removeAll()
                    self.arrOrderHistory = (apiData.data?.list ?? [])
                } else {
                    self.arrOrderHistory = self.arrOrderHistory + (apiData.data?.list ?? [])
                }
                let plusVal = ((apiData.data?.total ?? 0) % self.pageSize) == 0 ? 0 : 1
                self.totalPages = ((apiData.data?.total ?? 0) / self.pageSize) + plusVal
                debugPrint("self.totalPages",self.totalPages)
            }
            completion()
        })
    }
    
}
