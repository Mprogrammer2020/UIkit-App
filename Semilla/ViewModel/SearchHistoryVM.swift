//
//  SearchHistoryVM.swift
//  Semilla
//
//  Created by Netset on 21/12/23.
//

import UIKit


class SearchHistoryVM {
    
    var arrRecentList = [RecentListingDetails]()
    var arrCategoryList = [CategoryList]()
    var selectCategoryId = Int()
    var number = Int()
    var pageNumber = 0
    var pageSize = 12
    var totalPages = Int()
    var arrCultivator = [CultivatorList]()
    let refreshControl = UIRefreshControl()
    var name = String()
    
    func searchListedApiMethod(_ categoryId: Int,isLoader:Bool,completion:@escaping() -> Void) {
        var param = [
            AppParam.HomeRecentlyListed.page: "\(pageNumber)",
            AppParam.HomeRecentlyListed.size: "\(pageSize)",
            AppParam.HomeRecentlyListed.name: "\(name)",
            AppParam.cultivatorList.latitude : "\(userCurrentLat)",
            AppParam.cultivatorList.longitude : "\(userCurrentLong)"
        ]
        if categoryId != 0 {
            param[AppParam.HomeRecentlyListed.categoryId] = "\(categoryId)"
        }
        WebServices.shared.getDataWithoutVersionUpdate(ApiUrl.searchHistory, showIndicator: true) { (response) in
            self.refreshControl.endRefreshing()
            if self.pageNumber == 0 {
                self.arrRecentList.removeAll()
            }
            if response.isSuccess {
                let apiData = Constants.shared.jsonDecoder.decode(model: RecentlyListed.self, data: response.data)!
                if self.pageNumber == 0 {
                    self.arrRecentList = apiData.data?.list ?? []
                } else {
                    self.arrRecentList = self.arrRecentList + (apiData.data?.list ?? [])
                }
                let plusVal = ((apiData.data?.total ?? 0) % self.pageSize == 0 ? 0 : 1)
                self.totalPages = ((apiData.data?.total ?? 0) / self.pageSize) + plusVal
            } else {
                Alerts.shared.showAlert(title: AlertMessages.appName, message: response.message)
            }
            completion()
        }
    }
    
    func recentlyListedApiMethod(_ categoryId: Int,isLoader: Bool,completion:@escaping() -> Void) {
        var param = [
            AppParam.HomeRecentlyListed.page: "\(pageNumber)",
            AppParam.HomeRecentlyListed.size: "\(pageSize)",
            AppParam.HomeRecentlyListed.name: "\(name)",
            AppParam.cultivatorList.latitude : "\(userCurrentLat)",
            AppParam.cultivatorList.longitude : "\(userCurrentLong)"
        ]
        if categoryId != 0 {
            param[AppParam.HomeRecentlyListed.categoryId] = "\(categoryId)"
        }
        WebServices.shared.postData(ApiUrl.recetlyListed, params: param, showIndicator: isLoader, methodType: .post, completion: { response in
            self.refreshControl.endRefreshing()
            if self.pageNumber == 0 {
                self.arrRecentList.removeAll()
            }
            if response.isSuccess {
                let apiData = Constants.shared.jsonDecoder.decode(model: RecentlyListed.self, data: response.data)!
                if self.pageNumber == 0 {
                    self.arrRecentList = apiData.data?.list ?? []
                } else {
                    self.arrRecentList = self.arrRecentList + (apiData.data?.list ?? [])
                }
                let plusVal = ((apiData.data?.total ?? 0) % self.pageSize == 0 ? 0 : 1)
                self.totalPages = ((apiData.data?.total ?? 0) / self.pageSize) + plusVal
            } else {
                Alerts.shared.showAlert(title: AlertMessages.appName, message: response.message)
            }
            completion()
        })
    }
    
    
//    func categeoriesApiMethod(_ isLoader:Bool, completion:@escaping() -> Void) {
//        WebServices.shared.getData(ApiUrl.categeory, showIndicator: isLoader) { (response) in
//            self.arrCategoryList.removeAll()
//            if response.isSuccess {
//                let apiData = Constants.shared.jsonDecoder.decode(model: CategoryModelInfo.self, data: response.data)
//                self.arrCategoryList = apiData?.data?.list ?? []
//                let dataDict = NSMutableDictionary()
//                dataDict.setValue(AlertMessages.all, forKey: "name")
//                dataDict.setValue(0, forKey: "id")
//                dataDict.setValue("", forKey: "createdDate")
//                dataDict.setValue(true, forKey: "enabled")
//                do {
//                    let myDataNew = try JSONSerialization.data(withJSONObject: dataDict, options: [])
//                    let newObject = Constants.shared.jsonDecoder.decode(model: CategoryList.self, data: myDataNew)
//                    self.arrCategoryList.insert(newObject!, at: 0)
//                } catch {
//                    debugPrint(error.localizedDescription)
//                }
//            }
//            completion()
//        }
//    }
//    
    
}
