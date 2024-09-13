//
//  DriverReviewVM.swift
//  Semilla
//
//  Created by Netset on 26/02/24.
//

import Foundation

class DriverReviewVM {
    
    var orderId = Int()
    var objDriver:Driver?
    var isBackToNotify = Bool()
    var callBackAfterDriverReview:(()->())?
    
    func driverReviewApiMethod(_ request: DriverReviewRequest, id:Int,completion:@escaping() -> Void) {
        let result = performValidations(request)
        if !result.success {
            Alerts.shared.showAlert(title: AlertMessages.appName, message:  result.message ?? "")
        } else {
            let param = [
                AppParam.DriverRatingReview.rating : Int(request.rating),
                AppParam.DriverRatingReview.description : "\(request.message)"
            ] as [String:Any]
            WebServices.shared.postData("\(ApiUrl.driverReviews)/\(id)", params: param, showIndicator: true, methodType: .post) { (response) in
                if response.isSuccess {
                    let apiData = Constants.shared.jsonDecoder.decode(model: CheckoutModel.self, data: response.data)
                    self.objDriver = apiData?.data?.driverReview
                    completion()
                } else {
                    Alerts.shared.showAlert(title: AlertMessages.appName, message: response.message)
                }
            }
        }
    }
    
    // MARK: Perform Validations Method
    private func performValidations(_ request: DriverReviewRequest) -> ValidationResult {
        return RatingValidation.checkValidationsDriverReview(request)
    }
    
}
