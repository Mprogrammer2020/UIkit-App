//
//  ProductReviewVM.swift
//  Semilla
//
//  Created by Netset on 26/02/24.
//

import Foundation

class ProductReviewVM {
    
    var orderId = Int()
    var isFromNotify = Bool()
    var callBackAfterCultivatorReview:(()->())?
    
    func productReviewApiMethod(_ request: ProductReviewRequest, id:Int,completion:@escaping() -> Void) {
        let result = performValidations(request)
        if !result.success {
            Alerts.shared.showAlert(title: AlertMessages.appName, message:  result.message ?? "")
        } else {
            let param = [
                AppParam.DriverRatingReview.rating : Int(request.rating),
                AppParam.DriverRatingReview.description : "\(request.message)"
            ] as [String:Any]
            WebServices.shared.postData("\(ApiUrl.productReviews)/\(id)", params: param, showIndicator: true, methodType: .post) { (response) in
                if response.isSuccess {
                    completion()
                } else {
                    Alerts.shared.showAlert(title: AlertMessages.appName, message: response.message)
                }
            }
        }
    }
    
    // MARK: Perform Validations Method
    private func performValidations(_ request: ProductReviewRequest) -> ValidationResult {
        return RatingValidation.checkValidationsProductReview(request)
    }
    
}
