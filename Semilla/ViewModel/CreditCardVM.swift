//
//  CreditCardVM.swift
//  Semilla
//
//  Created by netset on 13/12/23.
//

import Foundation

class CreditCardsVM {
    
    var objCardListResource = [CardListResource]()
    var selectedCardId = String()
    var isComingFromCart = String()
    var callbackNavigateToAddCard:((CardListResource?)->())?
    var callbackSelectCard:((CardListResource?)->())?
    
    func getCardListApiMethod(_ completion:@escaping() -> Void) {
        WebServices.shared.getData(ApiUrl.addCardDetails, showIndicator: true) { response in
            if response.isSuccess {
                let apiData = Constants.shared.jsonDecoder.decode(model:CardListModel.self, data: response.data)
                self.objCardListResource = apiData?.data?.list ?? []
                if (apiData?.data?.primary ?? "") != "" {
                    payuCardId = (apiData?.data?.primary ?? "")
                }
                completion()
            } else {
                Alerts.shared.showAlert(title: AlertMessages.appName, message: response.message)
            }
        }
    }
    
    func deleteCardApiMethod(_ id:String, completion:@escaping() -> Void) {
        WebServices.shared.postData("\(ApiUrl.deleteCard)/\(id)", params: [:], showIndicator: true, methodType: .delete) { response in
            if response.isSuccess {
                completion()
            } else {
                Alerts.shared.showAlert(title: AlertMessages.appName, message: response.message)
            }
        }
    }
    
    func selectedPrimaryCardApiMethod(_ id:String,completion: @escaping() -> Void) {
        WebServices.shared.postData("\(ApiUrl.selectedPrimaryCard)/\(id)", params: [:], showIndicator: true, methodType: .put) { response in
            if response.isSuccess {
                completion()
            } else {
                Alerts.shared.showAlert(title: AlertMessages.appName, message: response.message)
            }
        }
    }
    
}
