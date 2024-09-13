//
//  MyAddressesVM.swift
//  Semilla
//
//  Created by netset on 13/12/23.
//

import Foundation


class MyAddressesVM {

    var selectedAddressId = Int()
    var callbackSelectAddress:((MyAddressesList?)->())?
    var arrAddressList = [MyAddressesList]()
    var isComingFrom = String()

    
    func getAddressDataApiMethod(_ completion: @escaping() -> Void) {
        WebServices.shared.getData(ApiUrl.getAddressData, showIndicator: true) { response in
            if response.isSuccess {
                let apiData = Constants.shared.jsonDecoder.decode(model: MyAddressesModel.self, data: response.data)!
                self.arrAddressList = apiData.data?.list ?? []
                let arrList = self.arrAddressList.filter { $0.primaryA ?? false }
                if arrList.count > 0 {
                    self.selectedAddressId = arrList[0].id ?? 0
                    primaryAddressSaved = arrList[0]
                }
                completion()
            } else {
                Alerts.shared.showAlert(title: AlertMessages.appName, message: response.message)
            }
        }
    }
    
    func deleteAddressDataApiMethod(_ id:Int, completion: @escaping() -> Void) {
        WebServices.shared.postData("\(ApiUrl.deleteAddress)/\(id)", params: [:], showIndicator: true, methodType: .delete) { response in
            if response.isSuccess {
                completion()
            } else {
                Alerts.shared.showAlert(title: AlertMessages.appName, message: response.message)
            }
        }
    }

}
