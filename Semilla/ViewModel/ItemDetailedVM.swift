//
//  ItemDetailedVM.swift
//  Semilla
//
//  Created by netset on 11/12/23.
//

import Foundation

class ItemDetailedVM {
    
    var arrImagesList = [ProductImageList]()
    var selectedQtyId = Int()
    var objProductDetail:ProductInfo?
    var detailId = Int()
    var productId = Int()
    var callBackRefreshListData:(()->())?
    var isChangedValue = Bool()
    var isSearchHistory = Bool()
    var selectQty = [
        SelectQuantity(qty: "100g"),
        SelectQuantity(qty: "250g"),
        SelectQuantity(qty: "500g"),
        SelectQuantity(qty: "1kg"),
        SelectQuantity(qty: "3kg"),
        SelectQuantity(qty: "5kg")
    ]

    func productCultivatorIDApiMethod(_ id:Int,completion:@escaping() -> Void) {
        WebServices.shared.getDataWithoutVersionUpdate("\(ApiUrl.productDetail)/\(id)?cartQuantity=true&searchHistory=\(isSearchHistory)", showIndicator: true) { (response) in
            if response.isSuccess {
                let apiData = Constants.shared.jsonDecoder.decode(model: ProductDetailModel.self, data: response.data)
                self.objProductDetail = apiData?.data?.resource
                self.objProductDetail?.cartQuantity = apiData?.data?.cartQuantity
                completion()
            } else {
                Alerts.shared.showAlert(title: AlertMessages.appName, message: response.message)
            }
        }
    }
    
    func productDetailImagesApiMethod(_ id:Int,completion:@escaping() -> Void) {
        WebServices.shared.getData("\(ApiUrl.productDetailImages)/\(id)", showIndicator: true) { (response) in
            if response.isSuccess {
                let apiData = Constants.shared.jsonDecoder.decode(model: ProductImageModel.self, data: response.data)
                self.arrImagesList = apiData?.data?.list ?? []
                completion()
            } else {
                Alerts.shared.showAlert(title: AlertMessages.appName, message: response.message)
            }
        }
    }
    
//    func quantityApiMethod(_ id:Int,completion:@escaping() -> Void) {
//        WebServices.shared.getData("\(ApiUrl.quantityStock)/\(id)", showIndicator: true) { (response) in
//            if response.isSuccess {
//                let apiData = Constants.shared.jsonDecoder.decode(model:ProductQuantityModel .self, data: response.data)
//                self.arrQuantityUnit = apiData?.data?.list ?? []
//                completion()
//            } else {
//                Alerts.shared.showAlert(title: AlertMessages.appName, message: response.message)
//            }
//        }
//    }
    
   
    
    func addReplacedItemTocardApiMethod(_ stockId:Int,completion:@escaping() -> Void) {
        WebServices.shared.postData("\(ApiUrl.addToCart)/\(stockId)?quantity=1&action=YES", params: [:], showIndicator: true, methodType: .put) { (response) in
            if response.isSuccess {
                completion()
            } else {
                Alerts.shared.showAlert(title: AlertMessages.appName, message: response.message)
            }
        }
    }
    
}
