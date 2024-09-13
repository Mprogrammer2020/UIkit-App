//
//  CultivatorVM.swift
//  Semilla
//
//  Created by Netset on 05/12/23.
//

import UIKit


class CultivatorVM {
    
    var arrDataCheck = [DataCheck]()
    var arrCultivator = [CultivatorList]()
    var selectUserIndex = Int()
    var pageNumber = 0
    var pageSize = 21
    var totalPages = Int()
    var search = String()
    let refreshControl = UIRefreshControl()
    var selectRatingVal = String()
    var distanceVal = Int()
    var selectCategoryIdVal = NSMutableArray()
    
    func cultivatorListApiMethod(_ isLoader:Bool, completion:@escaping() -> Void) {
        var param = [
            AppParam.cultivatorList.page: "\(pageNumber)",
            AppParam.cultivatorList.size: "\(pageSize)",
            AppParam.cultivatorList.search : "\(search)",
            AppParam.cultivatorList.latitude : "\(userCurrentLat)",
            AppParam.cultivatorList.longitude : "\(userCurrentLong)"
        ] as [String:Any]
        
        if distanceVal > 0 {
            param[AppParam.cultivatorList.latitude] = "\(userCurrentLat)"
            param[AppParam.cultivatorList.longitude] = "\(userCurrentLong)"
            param[AppParam.cultivatorList.distance] = "\(distanceVal)"
        }
        
        if selectCategoryIdVal.count > 0 {
            param[AppParam.cultivatorList.categoryIds] = (selectCategoryIdVal as Array)
        }
        if selectRatingVal != "" {
            param[AppParam.cultivatorList.rating] = "\(selectRatingVal)"
        }
        WebServices.shared.postData(ApiUrl.allCultivator, params: param, showIndicator: isLoader, methodType: .post, completion: { response in
            if self.pageNumber == 0 {
                self.arrCultivator.removeAll()
            }
            self.refreshControl.endRefreshing()
            if response.isSuccess {
                let apiData = Constants.shared.jsonDecoder.decode(model: CultivatorListModel.self, data: response.data)!
                if self.pageNumber == 0 {
                    self.arrCultivator.removeAll()
                    self.arrCultivator = apiData.data?.list ?? []
                } else {
                    self.arrCultivator = self.arrCultivator + (apiData.data?.list ?? [])
                }
                let plusVal = ((apiData.data?.total ?? 0) % self.pageSize == 0 ? 0 : 1)
                self.totalPages = ((apiData.data?.total ?? 0) / self.pageSize) + plusVal
            }
            completion()
        })
    }
    
}
