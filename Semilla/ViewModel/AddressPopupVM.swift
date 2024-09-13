//
//  AddressPopupVM.swift
//  Semilla
//
//  Created by Netset on 22/03/24.
//

import Foundation

class AddressPopupVM {
    
    var callbackSelectAddress:((MyAddressesList?,Int)->())?
    var callbackAddress:((AutoCompleteModel?)->())?
    var callbackDismiss:(()->())?
    var arrAddressList = [MyAddressesList]()
    var selectedIndex = -1
    
    func getAddressDataApiMethod(_ completion: @escaping() -> Void) {
        WebServices.shared.getData(ApiUrl.getAddressData, showIndicator: false) { response in
            if response.isSuccess {
                let apiData = Constants.shared.jsonDecoder.decode(model: MyAddressesModel.self, data: response.data)!
                self.arrAddressList = apiData.data?.list ?? []
                completion()
            } else {
                Alerts.shared.showAlert(title: AlertMessages.appName, message: response.message)
            }
        }
    }
    
}
