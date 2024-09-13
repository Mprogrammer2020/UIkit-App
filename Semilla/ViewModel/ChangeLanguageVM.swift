//
//  ChangeLanguageVM.swift
//  Semilla
//
//  Created by Netset on 23/04/24.
//

import Foundation


class ChangeLanguageVM {
    
    func selectedPrimaryLanguageMethod(_ selectedLang:String,completion: @escaping() -> Void) {
        WebServices.shared.postData("\(ApiUrl.selectLanguage)", params: [:], showIndicator: true, methodType: .put) { response in
            if response.isSuccess {
                completion()
            } else {
                Alerts.shared.showAlert(title: AlertMessages.appName, message: response.message)
            }
        }
    }
    
    
}
