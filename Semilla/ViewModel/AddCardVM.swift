//
//  AddCardVM.swift
//  Semilla
//
//  Created by Netset on 27/02/24.
//

import Foundation
import Stripe

class AddCardVM {
    
    var isFromShoppingCard = Bool()
    var totalCardCount = Int()
    
    func addCardApiMethod(_ request: AddCardRequest, completion:@escaping(CardListResource?) -> Void) {
        let result = performValidations(request)
        if !result.success {
            Alerts.shared.showAlert(title: AlertMessages.appName, message:  result.message ?? "")
        } else {
            let param = [
                AppParam.AddCard.cardNumber: "\(request.cardNo)",
                AppParam.AddCard.payerName: "\((request.cardUserName))",
                AppParam.AddCard.expirationDate: "\(request.cardExpDate)",
                AppParam.AddCard.paymentMethod: "\(request.cardCvv)"
            ]
            CommonMethod.shared.showActivityIndicator()
//            self.getToken(request) { (token, cardId) in
                WebServices.shared.postData(ApiUrl.addCardDetails, params: param, showIndicator: false, methodType: .post) { (response) in
                    CommonMethod.shared.hideActivityIndicator()
                    if response.isSuccess {
                        let apiData = Constants.shared.jsonDecoder.decode(model: CardListModel.self, data: response.data)
                        debugPrint(apiData?.data?.resource?.maskedNumber ?? "")
                        debugPrint(apiData?.data?.resource?.tokenId ?? "")
                        completion(apiData?.data?.resource)
                    } else {
                        Alerts.shared.showAlert(title: AlertMessages.appName, message: response.message)
                    }
                }
            }
        }
    }
    
    // MARK: Perform Validations Method
    private func performValidations(_ request: AddCardRequest) -> ValidationResult {
        return cardValidation.checkCardValidations(request)
    }
    
//    func getToken(_ request: AddCardRequest,completion:@escaping(_ token:String ,  _ cardId : String) -> Void){
//        let cardParams = STPCardParams()
//        cardParams.name = (request.cardUserName)
//        cardParams.number = request.cardNo.removeWhiteSpace()
//        cardParams.expMonth = UInt(request.cardMonth) 
//        cardParams.expYear = UInt(request.cardYear)
//        cardParams.cvc = (request.cardCvv)
//        STPAPIClient.shared.createToken(withCard: cardParams) { (token: STPToken?, error: Error?) in
//            guard let token = token,error == nil
//            else {
//                CommonMethod.shared.hideActivityIndicator()
//                Alerts.shared.showAlert(title: AlertMessages.appName, message: AlertMessages.incorrectCardDetails)
//                return
//            }
//            completion("\(token)", "\(token.card!.stripeID)")
//        }
//    }
    
//}
