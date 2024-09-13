//
//  DriverReviewProperties.swift
//  Semilla
//
//  Created by Baljinder [iMac] on 29/01/24.
//

import UIKit
import IQKeyboardManagerSwift

class DriverReviewProperties: UIView {
    
    //MARK: IBOutlet's
    @IBOutlet weak var lblWriteReview: UILabel!
    @IBOutlet weak var imgVwDriver: UIImageView!
    @IBOutlet weak var lblDriverName: UILabel!
    @IBOutlet weak var lblQuickRateYourDriverService: UILabel!
    @IBOutlet weak var vwRatingToDriver: FloatRatingView!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var txtVwFeedback: IQTextView!
    
    //MARK: Variable Declaration
    var objDelegateDriverReviews: DelegateDriverReviews?
    
    // MARK: View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        txtVwFeedback.placeholder = "\(ValidationMessages.letUsKnowWhatYouThink)"
    }
    
    //MARK: IBAction's
    @IBAction func actionBtnSubmit(_ sender: UIButton) {
        let request = DriverReviewRequest(rating: vwRatingToDriver.rating, message: txtVwFeedback.text ?? "")
        self.objDelegateDriverReviews?.goToReviewSubmit(request)
    }
    
    @IBAction func actionBtnCancel(_ sender: UIButton) {
        self.objDelegateDriverReviews?.goToBack()
    }
    
    func showDetails(_ request:Driver?) {
        lblDriverName.text = "\(request?.firstName ?? "") \(request?.lastName ?? "")"
        imgVwDriver.setImageOnImageViewServer(request?.imagePath ?? "", placeholder: UIImage(named: "ic_placeholder")!)
    }
    
}


extension DriverReviewProperties: UITextViewDelegate  {
    
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
