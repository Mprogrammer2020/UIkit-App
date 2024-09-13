//
//  ShoppingCartVM.swift
//  Semilla
//
//  Created by Netset on 05/12/23.
//

import Foundation

class ShoppingCartVM {
    
    var arrShoppingCartData = [ShoppingCartList]()
    var shoppingCartData : ShoppingCartData?
    var selectedId = Int()
    var objTotalModelInfo:TotalModelInfo?
    var arrAddress: MyAddressesList?
    var arrCard : CardListResource?
    var arrOrderPlace : TotalModelInfo?
    var orderId = Int()
    var objExtrasETAModel:ExtrasETAModel?
    var isDeliverableOrder:Bool?
    
    func getCartData(_ completion:@escaping() -> Void) {
        WebServices.shared.getDataWithoutVersionUpdate(ApiUrl.getCartdata, showIndicator: true) { (response) in
            if response.isSuccess {
                let apiData = Constants.shared.jsonDecoder.decode(model:ShoppingCartModel .self, data: response.data)
                self.arrShoppingCartData = apiData?.data?.list ?? []
                self.objTotalModelInfo = apiData?.data?.total
                self.objExtrasETAModel = apiData?.data?.extras
                self.shoppingCartData = apiData?.data
                self.isDeliverableOrder = (self.objExtrasETAModel?.deliverable)
                completion()
            } else {
                Alerts.shared.showAlert(title: AlertMessages.appName, message: response.message)
            }
        }
    }
    
    
    func getPrimaryAddressApiMethod(_ completion:@escaping() -> Void) {
        WebServices.shared.getDataWithoutVersionUpdate(ApiUrl.getMyPrimaryAddress, showIndicator: true) { (response) in
            if response.isSuccess {
                let apiData = Constants.shared.jsonDecoder.decode(model:MyAddressesModel .self, data: response.data)
                self.arrAddress = apiData?.data?.resource
                completion()
            } else {
                Alerts.shared.showAlert(title: AlertMessages.appName, message: response.message)
            }
        }
    }
    
    func getPrimaryCardApiMethod(_ completion:@escaping() -> Void) {
        WebServices.shared.getData(ApiUrl.getMyPrimaryCard, showIndicator: true) { (response) in
            if response.isSuccess {
                let apiData = Constants.shared.jsonDecoder.decode(model:CardListModel .self, data: response.data)
                self.arrCard = apiData?.data?.card
                payuCardId = (apiData?.data?.card?.tokenId ?? "")
                completion()
            } else {
                Alerts.shared.showAlert(title: AlertMessages.appName, message: response.message)
            }
        }
    }
    
    func orderPlaceApiMethod(_ completion:@escaping(Bool) -> Void) {
        let param = [
            AppParam.Checkout.cultivatorId : "\(arrShoppingCartData[0].cultivatorId ?? 0)",
            AppParam.Checkout.itemTotal : "\(objTotalModelInfo?.itemTotal ?? 0)",
            AppParam.Checkout.deliveryFee : "\(objTotalModelInfo?.deliveryFee ?? 0)",
            AppParam.Checkout.serviceFee : "\(objTotalModelInfo?.serviceFee ?? 0)",
            AppParam.Checkout.cartTotal : "\(objTotalModelInfo?.cartTotal ?? 0)",
            AppParam.Checkout.creditsUsed : "\(objTotalModelInfo?.creditsUsed ?? 0)",
            AppParam.Checkout.addressId : "\(arrAddress?.id ?? 0)",
            AppParam.Checkout.cardToken : "\(arrCard?.tokenId ?? "")"
        ]
        WebServices.shared.postData(ApiUrl.orderPlace, params: param, showIndicator: true, methodType: .post) { response in
            if response.isSuccess {
                if let dataObj = response.JSON["data"] as? NSDictionary {
                    if let orderDict = dataObj["order"] as? NSDictionary {
                        self.orderId = getIntegerValue(orderDict["id"] as Any)
                        completion(true)
                    } else {
                        completion(false)
                    }
                } else {
                    completion(false)
                }
            } else {
                Alerts.shared.showAlert(title: AlertMessages.appName, message: response.message)
            }
        }
    }
    
    func etaShowApiMethod(_ addressId:Int, completion:@escaping() -> Void) {
        WebServices.shared.getDataWithoutVersionUpdate("\(ApiUrl.estimatedTime)/\(addressId)", showIndicator: true) { (response) in
            if response.isSuccess {
                let apiData = Constants.shared.jsonDecoder.decode(model:ShoppingCartModel .self, data: response.data)
                self.objExtrasETAModel = apiData?.data?.extras
                self.objTotalModelInfo = apiData?.data?.total
                self.isDeliverableOrder = (self.objExtrasETAModel?.deliverable)
                completion()
            } else {
                Alerts.shared.showAlert(title: AlertMessages.appName, message: response.message)
            }
        }
    }
    
    
    func CreditsAppliedApiMethod(_ addressId:Int,creditsUsed:Bool,isLoader:Bool, completion:@escaping() -> Void) {
        WebServices.shared.getDataWithoutVersionUpdate("\(ApiUrl.estimatedTime)/\(addressId)?creditsUsed=\(creditsUsed)", showIndicator: isLoader) { (response) in
            if response.isSuccess {
                let apiData = Constants.shared.jsonDecoder.decode(model:ShoppingCartModel .self, data: response.data)
                self.objExtrasETAModel = apiData?.data?.extras
                self.objTotalModelInfo = apiData?.data?.total
                self.isDeliverableOrder = (self.objExtrasETAModel?.deliverable)
                completion()
            }
        }
    }
    
}

