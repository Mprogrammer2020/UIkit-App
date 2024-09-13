//
//  HomeVM.swift
//  Semilla
//
//  Created by Netset on 30/11/23.
//

import UIKit

class HomeVM {
    
    var arrRecentList = [RecentListingDetails]()
    var arrCategoryList = [CategoryList]()
    var selectCategoryId = Int()
    var selectSavedAddIndex = -1
    var number = Int()
    var pageNumber = 0
    var pageSize = 6
    var totalPages = Int()
    var arrCultivator = [CultivatorList]()
    let refreshControl = UIRefreshControl()

    var arrFarmersList = [
        DataCheck(userName: "Danny Pino",userImages: "1",Rating: "4.5"),
        DataCheck(userName: "Wagner Moura",userImages: "2",Rating: "5.0"),
        DataCheck(userName: "Pedro Armendáriz",userImages: "3",Rating: "3.5"),
        DataCheck(userName: "Christian Meier",userImages: "4",Rating: "4.0")
    ]
    
    func recentlyListedApiMethod(_ categoryId: Int,isLoader:Bool,completion:@escaping() -> Void) {
        var param = [
            AppParam.HomeRecentlyListed.page: "\(pageNumber)",
            AppParam.HomeRecentlyListed.size: "\(pageSize)",
            AppParam.HomeRecentlyListed.latitude : "\(userCurrentLat)",
            AppParam.HomeRecentlyListed.longitude : "\(userCurrentLong)"
        ]
        if categoryId != 0 {
            param[AppParam.HomeRecentlyListed.categoryId] = "\(categoryId)"
        }
        WebServices.shared.postDataWithoutVersionUpdate(ApiUrl.recetlyListed, params: param, showIndicator: isLoader, methodType: .post, completion: { response in
            self.arrRecentList.removeAll()
            if response.isSuccess {
                let apiData = Constants.shared.jsonDecoder.decode(model: RecentlyListed.self, data: response.data)!
                self.arrRecentList = apiData.data?.list ?? []
            }
            completion()
        })
    }
    
    func categeoriesApiMethod(_ isLoader:Bool, completion:@escaping() -> Void) {
        WebServices.shared.getData(ApiUrl.categeory, showIndicator: isLoader) { (response) in
            self.arrCategoryList.removeAll()
            if response.isSuccess {
                let apiData = Constants.shared.jsonDecoder.decode(model: CategoryModelInfo.self, data: response.data)
                self.arrCategoryList = apiData?.data?.list ?? []
                let dataDict = NSMutableDictionary()
                dataDict.setValue(AlertMessages.all, forKey: "name")
                dataDict.setValue(0, forKey: "id")
                dataDict.setValue("", forKey: "createdDate")
                dataDict.setValue(true, forKey: "enabled")
                do {
                    let myDataNew = try JSONSerialization.data(withJSONObject: dataDict, options: [])
                    let newObject = Constants.shared.jsonDecoder.decode(model: CategoryList.self, data: myDataNew)
                    self.arrCategoryList.insert(newObject!, at: 0)
                } catch{
                    debugPrint(error.localizedDescription)
                }
            }
            completion()
        }
    }
    
    
    func trandingCultivatorApiMethod(_ isLoader:Bool, completion:@escaping() -> Void) {
        let param = [
            AppParam.cultivatorList.page: "\(pageNumber)",
            AppParam.cultivatorList.size: "\(pageSize)",
            AppParam.cultivatorList.latitude : "\(userCurrentLat)",
            AppParam.cultivatorList.longitude : "\(userCurrentLong)"
        ]
        WebServices.shared.postDataWithoutVersionUpdate(ApiUrl.allCultivator, params: param, showIndicator: isLoader, methodType: .post, completion: { response in
            self.arrCultivator.removeAll()
            if response.isSuccess {
                let apiData = Constants.shared.jsonDecoder.decode(model: CultivatorListModel.self, data: response.data)!
                self.arrCultivator = apiData.data?.list ?? []
            }
            completion()
        })
    }
    
}
