//
//  HelpAndSupportVCExt.swift
//  Semilla
//
//  Created by Netset on 19/12/23.
//

import Foundation

extension HelpAndSupportVC: DelegatesHelpAndSupport {
    
    // MARK: Button Back Clicked
    func gotoBack() {
        self.popViewController(true)
    }
    
    // MARK: - Click Button Submit
    func goToMessageSent(_ request: HelpAndSupoortRequest) {
        self.objViewModel.contactUsApiMethod(request) {
            let viewController = getStoryboard(.home).instantiateViewController(withIdentifier: ViewControllers.messageSentVC) as! MessageSentVC
            self.vwProperties.txtFldEmail.text = ""
            self.vwProperties.txtFldFullName.text = ""
            self.vwProperties.txtVwMessage.text = ""
            viewController.callbackSubmit = {
                self.popViewController(true)
            }
            self.present(viewController, animated: true, completion: nil)
        }
    }
    
}
