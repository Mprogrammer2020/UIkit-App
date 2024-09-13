//
//  ProductReviewsProperties.swift
//  Semilla
//
//  Created by Baljinder [iMac] on 29/01/24.
//

import UIKit
import IQKeyboardManagerSwift

class ProductReviewsProperties: UIView {
    
    //MARK: IBOutlet's
    @IBOutlet weak var lblProductsReview: UILabel!
    @IBOutlet weak var lblGiveUSRating: UILabel!
    @IBOutlet weak var vwGiveRating: FloatRatingView!
    @IBOutlet weak var txtVwGiveFeedbackProducts: IQTextView!
    
    //MARK: Variable Declaration
    var objDelegateProductReviews: DelegateProductReviews?
    
    
    //MARK: - Viewlife Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        txtVwGiveFeedbackProducts.placeholder = "\(ValidationMessages.letUsKnowWhatYouThink)"
    }
    
    @IBAction func actionBtnSubmit(_ sender: UIButton) {
        let request = ProductReviewRequest(rating: vwGiveRating.rating, message: txtVwGiveFeedbackProducts.text ?? "")
        self.objDelegateProductReviews?.goToProductReviewSubmit(request)
    }
    
    
    @IBAction func actionBtnSkip(_ sender: UIButton) {
        self.objDelegateProductReviews?.goToCheckout()
    }
    
}


extension ProductReviewsProperties: UITextViewDelegate  {
    
    // MARK: Text View Delegate Method
       func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
           let _char = text.cString(using: String.Encoding.utf8)
           let isBackSpace: Int = Int(strcmp(_char, "\\b"))
           if isBackSpace == -92 {
               return true
           }
           if (textView.text?.count == 0 && text == " ") || (textView.text?.count == 0 && text == "\n") {
               return false
           }
           if (range.location == 0 && text == " ") {
               return false
           }
           if textView.text.count > 200 {
               return false
           }
           return true
       }
    
}
