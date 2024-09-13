//
//  CustomizeQuantityVM.swift
//  Semilla
//
//  Created by Netset on 27/02/24.
//

import Foundation


class CustomizeQuantityVM {
    
    //MARK: variable declaration
    var objTotalModelInfo:TotalModelInfo?
    var stockId = Int()
    var objQuantityUnit:ProductInfo?
    
    func quantityApiMethod(_ id:Int,completion:@escaping() -> Void) {
        WebServices.shared.getData("\(ApiUrl.quantityStock)/\(id)", showIndicator: true) { (response) in
            if response.isSuccess {
                let apiData = Constants.shared.jsonDecoder.decode(model:ProductQuantityModel .self, data: response.data)
                self.objQuantityUnit = apiData?.data?.resource
                completion()
            } else {
                Alerts.shared.showAlert(title: AlertMessages.appName, message: response.message)
            }
        }
    }
    
    
    func addToCartApiMethod(_ stockId:Int,quantity:Int,completion:@escaping(Bool) -> Void) {
        WebServices.shared.postData("\(ApiUrl.increaseItemCount)/\(stockId)?quantity=\(quantity)", params: [:], showIndicator: false, methodType: .put) { (response) in
            if response.isSuccess {
                let apiData = Constants.shared.jsonDecoder.decode(model:ShoppingCartModel.self, data: response.data)
                self.objTotalModelInfo = apiData?.data?.total
                if (apiData?.data?.Replace ?? "") == "True" {
                    Alerts.shared.alertMessageWithActionOkAndCancelYesNo(title: AlertMessages.appName, message: apiData?.message ?? "") {
                        completion(true)
                    }
                } else {
                    completion(false)
                }
            } else {
                Alerts.shared.showAlert(title: AlertMessages.appName, message: response.message)
            }
        }
    }
    
    func addReplacedItemTocardApiMethod(_ stockId:Int,quantity:Int,completion:@escaping() -> Void) {
        WebServices.shared.postData("\(ApiUrl.addToCart)/\(stockId)/?quantity=\(quantity)&action=YES", params: [:], showIndicator: true, methodType: .put) { (response) in
            if response.isSuccess {
                completion()
            } else {
                Alerts.shared.showAlert(title: AlertMessages.appName, message: response.message)
            }
        }
    }
    
}
