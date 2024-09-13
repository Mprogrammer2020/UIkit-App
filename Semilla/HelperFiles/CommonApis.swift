//
//  CommonApis.swift
//  Semilla
//
//  Created by Netset on 26/02/24.
//

import Foundation

class CommonApis {
    static var shared: CommonApis {
        return CommonApis()
    }
    fileprivate init(){}
        
    // MARK: - Selected Primary Address Api Method
    func selectedPrimaryAddressApiMethod(_ id:Int,completion: @escaping() -> Void) {
        WebServices.shared.postDataWithoutVersionUpdate("\(ApiUrl.selectedPrimaryAddress)/\(id)", params: [:], showIndicator: true, methodType: .put) { response in
            if response.isSuccess {
                completion()
            } else {
                Alerts.shared.showAlert(title: AlertMessages.appName, message: response.message)
            }
        }
    }
    
    // MARK: - Shoppping Cart Count Api Method
    func shoppingCartCountApiMethod(_ completion:@escaping(AppAllCount) -> Void) {
        WebServices.shared.getDataWithoutVersionUpdate(ApiUrl.shoppingCartCount, showIndicator: false) { (response) in
            if response.isSuccess {
                if let dataObj = response.JSON["data"] as? NSDictionary {
                    let cartCount = getIntegerValue(dataObj["carCount"] as Any)
                    let request = AppAllCount(cartCount: cartCount)
                    completion(request)
                }
            } else {
                Alerts.shared.showAlert(title: AlertMessages.appName, message: response.message)
            }
        }
    }
    
    // MARK: - Update Token
    func updateDeviceTokenApi() {
        if accessTokenSaved != "" {
            WebServices.shared.postDataWithoutVersionUpdate(ApiUrl.updateDeviceToken, params: [:], showIndicator: false, methodType: .put) { (response) in
            }
        }
    }
    
    // MARK: - Common Api of Add To Cart
    func getOrderDetailInfoApiMethod(_ orderId: Int,completion:@escaping() -> Void) {
        WebServices.shared.getDataWithoutVersionUpdate("\(ApiUrl.orderDetails)/\(orderId)", showIndicator: true) { (response) in
            if response.isSuccess {
                let apiData = Constants.shared.jsonDecoder.decode(model: CheckoutModel.self, data: response.data)
                objDriverModel = apiData?.data?.order?.driver
                completion()
            }
        }
    }
    
    func cultivatorOfflineApiMethod(_ cultivatorId:Int,completion:@escaping() -> Void) {
        WebServices.shared.getDataWithoutVersionUpdate("\(ApiUrl.cultivatorStatus)/\(cultivatorId)", showIndicator: true) { (response) in
            if response.isSuccess {
                let apiData = Constants.shared.jsonDecoder.decode(model: CultivatorListModel.self, data: response.data)
                isOnline = apiData?.data?.online ?? false
                completion()
            }
        }
    }
    
    // MARK: -Common Api of Add To Cart
//    func addToCartApiMethod(_ productCultivatorId:Int,completion:@escaping(Bool) -> Void) {
//        WebServices.shared.postData("\(ApiUrl.addToCart)/\(productCultivatorId)", params: [:], showIndicator: true, methodType: .post) { response in
//            if response.isSuccess {
//                let apiData = Constants.shared.jsonDecoder.decode(model: SuccessModel.self, data: response.data)
//                if (apiData?.data?.Replace ?? "") == "True" {
//                    Alerts.shared.alertMessageWithActionOkAndCancelYesNo(title: AlertMessages.appName, message: apiData?.message ?? "") {
//                        completion(true)
//                    }
//                } else {
//                    completion(false)
//                }
//            } else {
//                Alerts.shared.showAlert(title: AlertMessages.appName, message: response.message)
//            }
//        }
//    }
    
    
    //MARK: - Common API of Increment and Decrement Count // &creditUsed=\(creditUsed)
    func getIncrDecreItemDataCount(_ id:Int,quantity:Int,completion:@escaping(ShoppingCartModel?) -> Void) {
        WebServices.shared.uploadMediaFiles("\(ApiUrl.increaseItemCount)/\(id)?quantity=\(quantity)", params: [:], docParam: [:], paramDoc: [:], imageParam: [:], videoParam: [:], showIndicator: false, methodType: .put) { (response) in
            if response.isSuccess {
                let apiData = Constants.shared.jsonDecoder.decode(model:ShoppingCartModel .self, data: response.data)
                completion(apiData)
            } else {
                Alerts.shared.showAlert(title: AlertMessages.appName, message: response.message)
            }
        }
    }
    
    //MARK: - Common API of Item Replace
    func addReplacedItemTocardApiMethod(_ stockId:Int,quantity:Int,completion:@escaping() -> Void) {
        WebServices.shared.postDataWithoutVersionUpdate("\(ApiUrl.addToCart)/\(stockId)/?quantity=\(quantity)&action=YES", params: [:], showIndicator: true, methodType: .put) { (response) in
            if response.isSuccess {
                completion()
            } else {
                Alerts.shared.showAlert(title: AlertMessages.appName, message: response.message)
            }
        }
    }
    
    func setPrimaryCardApiMethod(_ id:String,completion: @escaping() -> Void) {
        WebServices.shared.postDataWithoutVersionUpdate("\(ApiUrl.selectedPrimaryCard)/\(id)", params: [:], showIndicator: true, methodType: .put) { response in
            if response.isSuccess {
                completion()
            } else {
                Alerts.shared.showAlert(title: AlertMessages.appName, message: response.message)
            }
        }
    }
    
}


struct AppAllCount {
    var cartCount = Int()
}
