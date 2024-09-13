//
//  CheckoutVM.swift
//  Semilla
//
//  Created by Netset on 15/12/23.
//

import Foundation


class CheckoutVM {
    
    var orderId = Int()
    var objOrderDetail : CheckoutData?
    var objRatingReviews : CheckoutData?
    var arrItemList = [ShoppingCartList]()
    var cultivatorReview : CheckOutCultivator?
    var driverReview : Driver?
    var objAddress : Address?
    var objExtrasETAModel:ExtrasETAModel?
    var objTotalInfo : TotalModelInfo?
    var callBackOrderCancel:(()->())?
    var isBackToHome = Bool()
    
    func getOrderDetailApiMethod(_ completion:@escaping() -> Void) {
        WebServices.shared.getData("\(ApiUrl.orderDetails)/\(orderId)?eta=true&driverReview=true", showIndicator: true) { (response) in
            if response.isSuccess {
                let apiData = Constants.shared.jsonDecoder.decode(model: CheckoutModel.self, data: response.data)
                self.objOrderDetail = apiData?.data
                self.arrItemList = apiData?.data?.order?.products ?? []
                self.objExtrasETAModel = apiData?.data?.extras
                self.objAddress = apiData?.data?.deliveryAddress
                objDriverModel = apiData?.data?.order?.driver
                completion()
            } else {
                Alerts.shared.showAlert(title: AlertMessages.appName, message: response.message)
            }
        }
    }
    
    func getOrderReviewsApiMethod(_ completion:@escaping() -> Void) {
        WebServices.shared.getDataWithoutVersionUpdate("\(ApiUrl.orderReview)/\(orderId)", showIndicator: true) { (response) in
            if response.isSuccess {
                let apiData = Constants.shared.jsonDecoder.decode(model: CheckoutModel.self, data: response.data)
                self.cultivatorReview = apiData?.data?.cultivatorReview
                self.driverReview = apiData?.data?.driverReview
                completion()
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
                self.objTotalInfo = apiData?.data?.total
                completion()
            } else {
                Alerts.shared.showAlert(title: AlertMessages.appName, message: response.message)
            }
        }
    }
    
    func orderCancelApiMethod(_ orderId:Int, completion:@escaping() -> Void) {
        WebServices.shared.uploadMediaFiles("\(ApiUrl.orderCancel)/\(orderId)", params: [:], docParam: [:], paramDoc: [:], imageParam: [:], videoParam: [:], showIndicator: false, methodType: .put) { (response) in
            if response.isSuccess {
                completion()
            } else {
                Alerts.shared.showAlert(title: AlertMessages.appName, message: response.message)
            }
        }
    }
    
    
}
