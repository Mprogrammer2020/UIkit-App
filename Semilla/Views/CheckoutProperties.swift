//
//  CheckoutProperties.swift
//  Semilla
//
//  Created by netset on 11/12/23.
//

import UIKit

class CheckoutProperties: UIView {
    
    //IBoutlet's
    @IBOutlet weak var imgVwCongratulations: UIImageView!
    @IBOutlet weak var cnstHeightimgVwCongratulations: NSLayoutConstraint!
    @IBOutlet weak var lblHeaderCheckout: UILabel!
    @IBOutlet weak var tblVwItemsList: UITableView!
    @IBOutlet weak var lblDeliveryAddress: UILabel!
    @IBOutlet weak var btnGoToHome: UIButton!
    @IBOutlet weak var vwNoDriverAssign: UIView!
    @IBOutlet weak var constHeightNoDriverAssign: NSLayoutConstraint!
    @IBOutlet weak var cnstHeightGoToHomeButton: NSLayoutConstraint!
    @IBOutlet weak var vwGoToHomeButton: Gradient!
    @IBOutlet weak var vwDriverDetails: UIView!
    @IBOutlet weak var lblDriverDetails: UILabel!
    @IBOutlet weak var lblDriverID: UILabel!
    @IBOutlet weak var lblDriverName: UILabel!
    @IBOutlet weak var imgVwDriver: UIImageView!
    @IBOutlet weak var vwProvideDriversProductsFeedback: UIView!
    @IBOutlet weak var imgVwProductFeedback: UIImageView!
    @IBOutlet weak var vwDriversProductsComments: UIView!
    @IBOutlet weak var lblDriverFeedback: UILabel!
    @IBOutlet weak var vwDriverRating: FloatRatingView!
    @IBOutlet weak var lblDriverRating: UILabel!
    @IBOutlet weak var lblDriverFeedbackTimeAgo: UILabel!
    @IBOutlet weak var lblDriverFeedbackComment: UILabel!
    @IBOutlet weak var lblProductFeedback: UILabel!
    @IBOutlet weak var vwProductsRating: FloatRatingView!
    @IBOutlet weak var lblProductsRating: UILabel!
    @IBOutlet weak var lblProductsFeedbackTimeAgo: UILabel!
    @IBOutlet weak var lblProductsCommentFeedback: UILabel!
    @IBOutlet weak var vwBtnHome: UIView!
    //@IBOutlet weak var cnstHeightVwDriverProductsComments: NSLayoutConstraint! // 220
    @IBOutlet weak var lblUpprTiming: UILabel!
    @IBOutlet weak var cnstHeightVwProvideDriverProductsFeedback: NSLayoutConstraint! // 165
    @IBOutlet weak var cnstHeightDriverDetails: NSLayoutConstraint! // 115
    @IBOutlet weak var lblEstimatedArival: UILabel!
    @IBOutlet weak var lblTiming: UILabel!
    @IBOutlet weak var vwTrackAndCancelBtn: UIView!
    @IBOutlet weak var vwBtnCancel: UIView!
    @IBOutlet weak var lblCancel: UILabel!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var vwBtnTrackOrder: UIView!
    @IBOutlet weak var lblTrackOrder: UILabel!
    @IBOutlet weak var btnTrackOrder: UIButton!
    @IBOutlet weak var cnstHeightTblVw: NSLayoutConstraint! //180
    @IBOutlet weak var cnstHeightVwonlyOrderTestStatus: NSLayoutConstraint! // 140
    @IBOutlet weak var vwEstimatedArrival: UIView!
    @IBOutlet weak var lblItemTotalAmount: UILabel!
    @IBOutlet weak var lblDeliveryFeeAmount: UILabel!
    @IBOutlet weak var lblTaxAmount: UILabel!
    @IBOutlet weak var lblCartTotalAmount: UILabel!
    @IBOutlet weak var vwBlankView: UIView!
    @IBOutlet weak var lblDriverOTP: UILabel!
    
    
    // MARK: Order Status Detail
    @IBOutlet weak var lblOutForDelivery: UILabel!
    @IBOutlet weak var lblOrderDeliveryTimeInMinutes: UILabel!
    @IBOutlet weak var lblMonitorDriverOnMap: UILabel!
    @IBOutlet weak var vwShowTimeOrderStatus: UIView!
    
    @IBOutlet weak var lblDescriptDoubleTextOrderStatus: UILabel!
    @IBOutlet weak var lblTitleDoubleTextOrderStatus: UILabel!
    @IBOutlet weak var vwDoubleTextOrderStatus: UIView!
    
    @IBOutlet weak var lblOnlyOrderTextStatus: UILabel!
    @IBOutlet weak var vwOnlyOrderTextStatus: UIView!
    
    @IBOutlet weak var cnstHeightVwTrackTimeDetail: NSLayoutConstraint!
    @IBOutlet weak var vwTrackTimeDetail: UIView!
    
    @IBOutlet weak var cnstHeightvwBtnHome: NSLayoutConstraint! // 110
    @IBOutlet weak var vwDriverReviewOnly: UIView!
    @IBOutlet weak var vwCultivatorReviewOnly: UIView!
    @IBOutlet weak var vwProvideFeedbackDriverOnly: UIView!
    @IBOutlet weak var vwProvideFeedbackCultivatorOnly: UIView!
    @IBOutlet weak var lblCreditsAppliedAmount: UILabel!
    @IBOutlet weak var vwCreditsApplied: UIView!
    @IBOutlet weak var cnstHeightCreditsApplied: NSLayoutConstraint!
    
    
    //MARK: Variable Declaration
    var objCheckoutDelegates: DelegatesCheckout?
    
    //MARK: Viewlife Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setLineSpacing()
    }
    
    //MARK: IBAction's
    @IBAction func actionBtnBack(_ sender: UIButton) {
        self.objCheckoutDelegates?.gotoBack()
    }
    
    @IBAction func actionBtnCancel(_ sender: UIButton) {
        self.objCheckoutDelegates?.orderCancel()
    }
    
    
    @IBAction func actionBtnTrackOrder(_ sender: UIButton) {
        self.objCheckoutDelegates?.gotoTrackOrder()
    }
    
    @IBAction func actionBtnGoToHome(_ sender: UIButton) {
        self.objCheckoutDelegates?.gotoBackToHome()
    }
    
    @IBAction func actionBtnCallDriver(_ sender: UIButton) {
        self.objCheckoutDelegates?.goToDriverCall()
    }
    
    @IBAction func actionBtnFeedbackDriver(_ sender: UIButton) {
        self.objCheckoutDelegates?.goToDriverReviews()
    }
    
    @IBAction func actionBtnFeedbackProducts(_ sender: UIButton) {
        self.objCheckoutDelegates?.goToProductReviews()
    }
    
    //MARK: Custom Function
    func setLineSpacing() {
        let addressText = "102nd St Ports, Maddison Heights New York USA"
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5.0
        let attributedString = NSMutableAttributedString(string: addressText)
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
        let secondLineRange = (addressText as NSString).range(of: "New York")
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: secondLineRange)
        lblDeliveryAddress.attributedText = attributedString
    }
    
}
extension CheckoutProperties {
    
    func hideShowRatingViews(_ isHide: Bool) {
        if isHide {
            vwDriverReviewOnly.isHidden = true
            vwCultivatorReviewOnly.isHidden = true
            vwDriversProductsComments.isHidden = true
        } else {
            vwDriverReviewOnly.isHidden = false
            vwCultivatorReviewOnly.isHidden = false
            vwDriversProductsComments.isHidden = false
        }
    }
    
    func setUpUIMethod(_ orderDetail: CheckoutData?) {
        let orderStatus = orderDetail?.order?.status ?? ""

        if orderStatus == ScreenTypes.order_Delievered || orderStatus == ScreenTypes.delivered  {
            vwShowTimeOrderStatus.isHidden = true
            vwDoubleTextOrderStatus.isHidden = true
            vwOnlyOrderTextStatus.isHidden = false
            lblOnlyOrderTextStatus.text =  AlertMessages.orderDeliveredSuccessfully
            cnstHeightVwonlyOrderTestStatus.constant = 110
            vwEstimatedArrival.isHidden = true
            lblTiming.isHidden = true
            vwTrackAndCancelBtn.isHidden = true
            cnstHeightVwTrackTimeDetail.constant = 0
            vwTrackTimeDetail.isHidden = true
            vwNoDriverAssign.isHidden = true
            constHeightNoDriverAssign.constant = 0
            vwGoToHomeButton.isHidden = true
            cnstHeightGoToHomeButton.constant = 0
            vwBtnHome.isHidden = true
            cnstHeightvwBtnHome.constant = 0
            vwDriverDetails.isHidden = true
            cnstHeightDriverDetails.constant = 0
            vwProvideDriversProductsFeedback.isHidden = false
            cnstHeightVwProvideDriverProductsFeedback.constant = 165
            lblDriverOTP.isHidden = true
            /*
            if cultivatorReview?.rating != 0 {
                vwProvideFeedbackCultivatorOnly.isHidden = true
                vwCultivatorReviewOnly.isHidden = false
            } else {
                vwProvideFeedbackCultivatorOnly.isHidden = false
                vwCultivatorReviewOnly.isHidden = true
            }
            if driverReview?.id != 0 {
                vwProvideFeedbackDriverOnly.isHidden = true
                vwDriverReviewOnly.isHidden = false
            } else  {
                vwProvideFeedbackDriverOnly.isHidden = false
                vwDriverReviewOnly.isHidden = true
            }
            if cultivatorReview?.rating != 0 && driverReview?.rating != 0  {
                cnstHeightVwDriverProductsComments.constant = 180
                cnstHeightVwProvideDriverProductsFeedback.constant = 0
            } else if cultivatorReview?.rating == 0 && driverReview?.rating == 0  {
                cnstHeightVwDriverProductsComments.constant = 0
            } else {
                cnstHeightVwDriverProductsComments.constant = 90
            }
        */
        } else if orderStatus == ScreenTypes.order_Cancelled || orderStatus == ScreenTypes.orderTimeOut {
            vwShowTimeOrderStatus.isHidden = true
            vwDoubleTextOrderStatus.isHidden = true
            vwOnlyOrderTextStatus.isHidden = false
            lblOnlyOrderTextStatus.text = ValidationMessages.orderHasBeenCancelled
            imgVwCongratulations.isHidden = true
            cnstHeightimgVwCongratulations.constant = 0
            cnstHeightVwonlyOrderTestStatus.constant  = 110
            vwEstimatedArrival.isHidden = true
            vwTrackAndCancelBtn.isHidden = true
            vwTrackAndCancelBtn.isHidden = true
            cnstHeightVwTrackTimeDetail.constant = 0
            vwTrackTimeDetail.isHidden = true
            vwNoDriverAssign.isHidden = true
            constHeightNoDriverAssign.constant = 0
            vwGoToHomeButton.isHidden = true
            cnstHeightGoToHomeButton.constant = 0
            vwBtnHome.isHidden = true
            cnstHeightvwBtnHome.constant = 0
            vwDriverDetails.isHidden = true
            cnstHeightDriverDetails.constant = 0
            vwProvideDriversProductsFeedback.isHidden = true
            cnstHeightVwProvideDriverProductsFeedback.constant = 0
            vwDriversProductsComments.isHidden = true
            hideShowRatingViews(true)
            lblDriverOTP.isHidden = true
        } else if orderStatus == ScreenTypes.order_Rejected {
            vwShowTimeOrderStatus.isHidden = true
            vwDoubleTextOrderStatus.isHidden = true
            vwOnlyOrderTextStatus.isHidden = false
            lblOnlyOrderTextStatus.text = ValidationMessages.orderHasBeenRejected
            imgVwCongratulations.isHidden = true
            cnstHeightimgVwCongratulations.constant = 0
            cnstHeightVwonlyOrderTestStatus.constant  = 110
            vwEstimatedArrival.isHidden = true
            vwTrackAndCancelBtn.isHidden = true
            vwTrackAndCancelBtn.isHidden = true
            cnstHeightVwTrackTimeDetail.constant = 0
            vwTrackTimeDetail.isHidden = true
            vwNoDriverAssign.isHidden = true
            constHeightNoDriverAssign.constant = 0
            vwGoToHomeButton.isHidden = true
            cnstHeightGoToHomeButton.constant = 0
            vwBtnHome.isHidden = true
            cnstHeightvwBtnHome.constant = 0
            vwDriverDetails.isHidden = true
            cnstHeightDriverDetails.constant = 0
            vwProvideDriversProductsFeedback.isHidden = true
            cnstHeightVwProvideDriverProductsFeedback.constant = 0
            vwDriversProductsComments.isHidden = true
            hideShowRatingViews(true)
            lblDriverOTP.isHidden = true
        } else if orderStatus == ScreenTypes.order_Intiated || orderStatus == ScreenTypes.orderAccept || orderStatus == ScreenTypes.searching_Delivery_Partner || orderStatus == ScreenTypes.pickup_Confirmation_Pending {
            vwShowTimeOrderStatus.isHidden = true
            vwDoubleTextOrderStatus.isHidden = true
            vwOnlyOrderTextStatus.isHidden = false
            vwNoDriverAssign.isHidden = false
            constHeightNoDriverAssign.constant = 65
            vwGoToHomeButton.isHidden = true
            cnstHeightGoToHomeButton.constant = 0
            vwBtnHome.isHidden = true
            cnstHeightvwBtnHome.constant = 0
            vwDriverDetails.isHidden = true
            cnstHeightDriverDetails.constant = 0
            vwProvideDriversProductsFeedback.isHidden = true
            cnstHeightVwProvideDriverProductsFeedback.constant = 0
            vwDriversProductsComments.isHidden = true
            hideShowRatingViews(true)
            lblDriverOTP.isHidden = true
//        } else if  orderStatus == ScreenTypes.pickup_Confirm {
//            vwShowTimeOrderStatus.isHidden = true
//            vwDoubleTextOrderStatus.isHidden = false
//            vwOnlyOrderTextStatus.isHidden = true
//            vwBtnCancel.backgroundColor = .systemBackground
//            lblCancel.isHidden = true
//            btnCancel.isHidden = true
//            vwNoDriverAssign.isHidden = true
//            constHeightNoDriverAssign.constant = 0
//            vwGoToHomeButton.isHidden = true
//            cnstHeightGoToHomeButton.constant = 0
//            vwBtnHome.isHidden = true
//            cnstHeightvwBtnHome.constant = 0
//            vwDriverDetails.isHidden = false
//            cnstHeightDriverDetails.constant = 115
//            vwProvideDriversProductsFeedback.isHidden = true
//            cnstHeightVwProvideDriverProductsFeedback.constant = 0
//            vwDriversProductsComments.isHidden = true
//            cnstHeightVwDriverProductsComments.constant = 0
//            if (orderDetail?.driver?.firstName ?? "" ) == "" {
//                vwNoDriverAssign.isHidden = false
//                constHeightNoDriverAssign.constant = 65
//                vwDriverDetails.isHidden = true
//                cnstHeightDriverDetails.constant = 0
//            }
        }else if orderStatus == ScreenTypes.pickUpPartnerVerified ||  orderStatus == ScreenTypes.pickup_Confirm {
            vwShowTimeOrderStatus.isHidden = false
            vwDoubleTextOrderStatus.isHidden = true
            vwOnlyOrderTextStatus.isHidden = true
            vwBtnCancel.backgroundColor = .systemBackground
            lblCancel.isHidden = true
            btnCancel.isHidden = true
            vwNoDriverAssign.isHidden = true
            constHeightNoDriverAssign.constant = 0
            vwGoToHomeButton.isHidden = true
            cnstHeightGoToHomeButton.constant = 0
            vwBtnHome.isHidden = true
            cnstHeightvwBtnHome.constant = 0
            vwDriverDetails.isHidden = false
            cnstHeightDriverDetails.constant = 115
            vwProvideDriversProductsFeedback.isHidden = true
            cnstHeightVwProvideDriverProductsFeedback.constant = 0
            vwDriversProductsComments.isHidden = true
            hideShowRatingViews(true)
            lblDriverOTP.isHidden = true
        } else if orderStatus == ScreenTypes.out_For_Delivery{
            vwShowTimeOrderStatus.isHidden = false
            vwDoubleTextOrderStatus.isHidden = true
            vwOnlyOrderTextStatus.isHidden = true
            vwBtnCancel.backgroundColor = .systemBackground
            lblCancel.isHidden = true
            btnCancel.isHidden = true
            vwNoDriverAssign.isHidden = true
            constHeightNoDriverAssign.constant = 0
            vwGoToHomeButton.isHidden = true
            cnstHeightGoToHomeButton.constant = 0
            vwBtnHome.isHidden = true
            cnstHeightvwBtnHome.constant = 0
            vwDriverDetails.isHidden = false
            cnstHeightDriverDetails.constant = 115
            vwProvideDriversProductsFeedback.isHidden = true
            cnstHeightVwProvideDriverProductsFeedback.constant = 0
            vwDriversProductsComments.isHidden = true
            hideShowRatingViews(true)
            lblDriverOTP.isHidden = false
        } else if orderStatus == ScreenTypes.atDeliveryLocation {
            vwShowTimeOrderStatus.isHidden = true
            vwDoubleTextOrderStatus.isHidden = false
            vwOnlyOrderTextStatus.isHidden = true
            vwBtnCancel.backgroundColor = .systemBackground
            lblCancel.isHidden = true
            btnCancel.isHidden = true
            vwNoDriverAssign.isHidden = true
            constHeightNoDriverAssign.constant = 0
            vwGoToHomeButton.isHidden = true
            cnstHeightGoToHomeButton.constant = 0
            vwBtnHome.isHidden = true
            cnstHeightvwBtnHome.constant = 0
            vwDriverDetails.isHidden = false
            cnstHeightDriverDetails.constant = 115
            vwProvideDriversProductsFeedback.isHidden = true
            cnstHeightVwProvideDriverProductsFeedback.constant = 0
            vwDriversProductsComments.isHidden = true
            hideShowRatingViews(true)
            lblDriverOTP.isHidden = false
        } else {
            vwShowTimeOrderStatus.isHidden = true
            vwDoubleTextOrderStatus.isHidden = true
            vwOnlyOrderTextStatus.isHidden = false
            lblOnlyOrderTextStatus.text = AlertMessages.orderHasBeenPlacedSuccessfully
            vwNoDriverAssign.isHidden = false
            vwGoToHomeButton.isHidden = false
            vwBtnHome.isHidden = false
            vwDriverDetails.isHidden = true
            cnstHeightDriverDetails.constant = 0
            vwProvideDriversProductsFeedback.isHidden = true
            cnstHeightVwProvideDriverProductsFeedback.constant = 0
            vwDriversProductsComments.isHidden = true
            hideShowRatingViews(true)
            cnstHeightGoToHomeButton.constant =  0
            cnstHeightvwBtnHome.constant = 0
        }
    }
    
    func showDetails(_ request: CheckoutData?) {
        
        if (request?.order?.deliveryAddress?.city ?? "") != "" {
            lblDeliveryAddress.text = "\(request?.order?.deliveryAddress?.apartmentNumber ?? ""), \(request?.order?.deliveryAddress?.address ?? ""), \(request?.order?.deliveryAddress?.city ?? ""), \(request?.order?.deliveryAddress?.country ?? "")"
        } else {
            lblDeliveryAddress.text = "\(request?.order?.deliveryAddress?.apartmentNumber ?? ""), \(request?.order?.deliveryAddress?.address ?? ""), \(request?.order?.deliveryAddress?.country ?? "")"
        }
        lblDriverID.text = "\(request?.order?.driver?.id ?? 0)"
        lblDriverOTP.text = "\(request?.order?.otp ?? "")"
        lblDriverName.text = "\(request?.order?.driver?.firstName ?? "") \(request?.order?.driver?.lastName ?? "")"
        imgVwDriver.setImageOnImageViewServer(request?.order?.driver?.imagePath ?? "", placeholder: UIImage(named: "ic_placeholder")!)
        lblItemTotalAmount.text = "$\(CommonMethod.shared.convertToColombianPeso(amount: (request?.order?.grossAmount ?? 0)) ?? "")" // "$\((request?.order?.grossAmount ?? 0).addZero)"
        lblDeliveryFeeAmount.text = "$\(CommonMethod.shared.convertToColombianPeso(amount: (request?.order?.deliveryFee ?? 0)) ?? "")" // "$\((request?.order?.deliveryFee ?? 0).addZero)"
        lblTaxAmount.text = "$\(CommonMethod.shared.convertToColombianPeso(amount: (request?.order?.serviceFee ?? 0)) ?? "")" //"$\((request?.order?.serviceFee ?? 0).addZero)"
        if (request?.order?.creditsUsed ?? 0) != 0 {
            vwCreditsApplied.isHidden = false
            lblCreditsAppliedAmount.text = "-$\(CommonMethod.shared.convertToColombianPeso(amount: (request?.order?.creditsUsed ?? 0)) ?? "")"
            setOTPTitle(request?.order?.otp ?? "")
        } else {
            vwCreditsApplied.isHidden = true
            lblCreditsAppliedAmount.text = "-$\(CommonMethod.shared.convertToColombianPeso(amount: 0.0) ?? "")"
            setOTPTitle(request?.order?.otp ?? "")
            lblCartTotalAmount.text = "$\(CommonMethod.shared.convertToColombianPeso(amount: (request?.order?.creditsUsed ?? 0)) ?? "")"
        }
    }
    
    func showRating(orderDetail:CheckoutData?,driverReview:Driver?, cultivatorReview:CheckOutCultivator?, etaTiming:ExtrasETAModel?) {
        hideShowRatingViews(true)
        cnstHeightVwProvideDriverProductsFeedback.constant = 0
        vwDriverRating.rating = Float(driverReview?.rating ?? 0)
        lblDriverRating.text = "\(driverReview?.rating ?? 0)"
        lblDriverFeedbackComment.text = driverReview?.description ?? ""
        lblProductsCommentFeedback.text = cultivatorReview?.description ?? ""
        vwProductsRating.rating = Float(cultivatorReview?.rating ?? 0)
        lblProductsRating.text = "\(cultivatorReview?.rating ?? 0)"
        lblProductsFeedbackTimeAgo.text = "\(UTCToLocal(cultivatorReview?.createdDate ?? "", backendFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", needFormat: "MMMM dd, yyyy"))"
        lblDriverFeedbackTimeAgo.text = "\(UTCToLocal(driverReview?.createdDate ?? "", backendFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", needFormat: "MMMM dd, yyyy"))"
        
        let timeStr = "\(UTCToLocal(cultivatorReview?.createdDate ?? "", backendFormat: DateFormats.UTCFormat1, needFormat: DateFormats.YYYYMMDDHHMMSS))"
        let timeString = "\(UTCToLocal(driverReview?.createdDate ?? "", backendFormat: DateFormats.UTCFormat1, needFormat: DateFormats.YYYYMMDDHHMMSS))"
        let cultivatorReviewDate = CommonMethod.shared.getDateFromSting(string: timeStr, stringFormat: DateFormats.YYYYMMDDHHMMSS)
        let driverReviewDate = CommonMethod.shared.getDateFromSting(string: timeString, stringFormat: DateFormats.YYYYMMDDHHMMSS)
        lblProductsFeedbackTimeAgo.text = cultivatorReviewDate.getElapsedInterval()
        lblDriverFeedbackTimeAgo.text = driverReviewDate.getElapsedInterval()
        
        lblTiming.text = "\(etaTiming?.eta ?? "")"
        lblUpprTiming.text = "\(etaTiming?.eta ?? "")"
        if (orderDetail?.order?.status ?? "") == ScreenTypes.order_Delievered {
            if (cultivatorReview?.rating ?? 0) != 0 {
                vwDriversProductsComments.isHidden = false
                vwProvideFeedbackCultivatorOnly.isHidden = true
                vwCultivatorReviewOnly.isHidden = false
            } else {
                vwProvideFeedbackCultivatorOnly.isHidden = false
                vwCultivatorReviewOnly.isHidden = true
            }
            if driverReview?.id ?? 0 != 0 {
                vwDriversProductsComments.isHidden = false
                vwProvideFeedbackDriverOnly.isHidden = true
                vwDriverReviewOnly.isHidden = false
            } else  {
                vwProvideFeedbackDriverOnly.isHidden = false
                vwDriverReviewOnly.isHidden = true
            }
            if (cultivatorReview?.rating ?? 0) != 0 && (driverReview?.rating ?? 0) != 0  {
                cnstHeightVwProvideDriverProductsFeedback.constant = 0
            } else {
                cnstHeightVwProvideDriverProductsFeedback.constant = 165
            }
        }
    }
    
    func setOTPTitle(_ OTP:String) {
        let formatStr = NSMutableAttributedString()
        formatStr.attributedString("OTP: ", color: UIColor(hexString: "#191919"), font: appFont(name: AppStyle.Fonts.interMedium, size: 14), lineHeight: 1.2, align: TextAlign.left).attributedString("\(OTP)", color: UIColor(hexString: "#000000"), font: appFont(name: AppStyle.Fonts.interMedium, size: 14), lineHeight: 1.2, align: TextAlign.left)
        lblDriverOTP.attributedText = formatStr
    }
    
}
