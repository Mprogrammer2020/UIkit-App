//
//  FilterVM.swift
//  Semilla
//
//  Created by netset on 13/12/23.
//

import Foundation


class FilterVM {
    
    
    var arrCategoryList = [FilterList]()
   
    var arrSectionList = ["\(ValidationMessages.categories)","\(ValidationMessages.ratings)","\(ValidationMessages.location)"]
    var arrRatingsList = [
        FilterRowData(nameStr: "5"),
        FilterRowData(nameStr: "4"),
        FilterRowData(nameStr: "3"),
        FilterRowData(nameStr: "2"),
        FilterRowData(nameStr: "1")
    ]
    var distance = 5
    var selectCategoryId = NSMutableArray()
    var selectRatingIndex = -1
    var selectRatingValue = String()
    var callbackFilter:((NSMutableArray,String,Int)->())?
    
    func categeoriesApiMethod(_ completion:@escaping() -> Void) {
        WebServices.shared.getData(ApiUrl.filterCategeory, showIndicator: true) { (response) in
            if response.isSuccess {
                let apiData = Constants.shared.jsonDecoder.decode(model: FilterDataModel.self, data: response.data)!
                self.arrCategoryList = (apiData.data?.list ?? [])
                completion()
            } else {
                Alerts.shared.showAlert(title: AlertMessages.appName, message: response.message)
            }
        }
    }
}
