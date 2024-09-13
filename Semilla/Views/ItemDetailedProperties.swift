//
//  ItemDetailedProperties.swift
//  Semilla
//
//  Created by Netset on 06/12/23.
//

import UIKit
import AdvancedPageControl

class ItemDetailedProperties: UIView {
    
    //MARK: IBOutlet's
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var vwBackButtons: UIView!
    @IBOutlet weak var lblHearderItemDetailed: UILabel!
    @IBOutlet weak var colVwItemDetails: UICollectionView!
    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var lblItemPrice: UILabel!
    @IBOutlet weak var lblItemQty: UILabel!
    @IBOutlet weak var lblItemDescription: UILabel!
    @IBOutlet weak var btnCustomizeQty: UIButton!
    @IBOutlet weak var btnAddToCart: UIButton!
    @IBOutlet weak var colVwQtySelect: UICollectionView!
    @IBOutlet weak var vwPageControl: AdvancedPageControlView!
    @IBOutlet weak var lblAddToCart: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblCultivatorName: UILabel!
    @IBOutlet weak var imgVwCultivator: UIImageView!
    @IBOutlet weak var lblReviews: UILabel!
    @IBOutlet weak var vWBtnAddTocart: Gradient!
    @IBOutlet weak var imgVwRatingStar: UIImageView!
    @IBOutlet weak var cnstWidthImgVwRating: NSLayoutConstraint!
    //    @IBOutlet weak var lblItemCutPrice: UILabel!
    //    @IBOutlet weak var vwDiscountLine: UIView!
    @IBOutlet weak var lblCostPerUnit: UILabel!
    @IBOutlet weak var cnstLeadinglblRating: NSLayoutConstraint!
    @IBOutlet weak var vwNoDataFound: UIView!
    @IBOutlet weak var btnCultivatorDetail: UIButton!
    @IBOutlet weak var vwAddedItemCountWithButtons: UIView!
    @IBOutlet weak var lblItemCount: UILabel!
    
    //MARK: Variables Declaration
    var itemImage: String?
    var objItemDetailedDelegates: DelegatesItemDetailed?
    var isAddToCart = Bool()
    
    //MARK: IBAction's
    @IBAction func actionbtnAddToCart(_ sender: UIButton) {
        if isAddToCart {
            self.objItemDetailedDelegates?.goToAddToCart()
        } else {
            self.objItemDetailedDelegates?.goToCart()
        }
    }
    
    @IBAction func actionBtnBack(_ sender: UIButton) {
        self.objItemDetailedDelegates?.gotoBack()
    }
    
    @IBAction func actionBtnCustoerReviews(_ sender: UIButton) {
        self.objItemDetailedDelegates?.goToCustomerReviews()
    }
    
    @IBAction func actionBtnCustomizeQty(_ sender: UIButton) {
        self.objItemDetailedDelegates?.gotoCustomizePopup()
    }
    
    @IBAction func actionBtnDecreaseItemCount(_ sender: UIButton) {
        self.objItemDetailedDelegates?.goToDecrementItem()
    }
    
    @IBAction func actionBtnIncreaseCount(_ sender: UIButton) {
        self.objItemDetailedDelegates?.goToIncrementItem()
    }
    
    
    //MARK: Custom Function
    func setupPageController(imageCount:Int) {
        let totalCount = imageCount
        if totalCount == 1 || totalCount == 0 {
            vwPageControl.isHidden = true
        } else {
            vwPageControl.isHidden = false
            vwPageControl.drawer = ScaleDrawer(numberOfPages: totalCount, height: 3.5, width: 11, space: 16, indicatorColor: AppStyle.AppColors.appColorGreen, dotsColor: UIColor.lightGray, isBordered: false, borderWidth: 0.0, indicatorBorderColor: .clear, indicatorBorderWidth: 0.0)
            vwPageControl.setPage(0)
        }
    }

    func congigurePageControl() {
        vwPageControl.drawer = ScaleDrawer(numberOfPages: 3, height: 3.5, width: 11, space: 16, indicatorColor: AppStyle.AppColors.appColorGreen, dotsColor: UIColor.lightGray, isBordered: false, borderWidth: 0.0, indicatorBorderColor: .clear, indicatorBorderWidth: 0.0)
    }
    
}

extension ItemDetailedProperties {
    
    func showDetail(_ detail:ProductInfo?) {
        lblHearderItemDetailed.text = DisplayNames.productDetails
        lblItemName.text = detail?.product?.name ?? ""
        lblItemPrice.text = "$\(CommonMethod.shared.convertToColombianPeso(amount: (detail?.product?.price ?? 0)) ?? "")" // "$\((detail?.product?.price ?? 0).addZero)"
        lblCostPerUnit.text = "$\(CommonMethod.shared.convertToColombianPeso(amount: (detail?.product?.pricePerUnit ?? 0) ) ?? "")/\(detail?.product?.unit?.unit ?? "")"//  "$\((detail?.product?.pricePerUnit ?? 0).addZero)/\(detail?.product?.unit?.unit ?? "")"
        lblItemQty.text = "\((detail?.product?.packaging ?? 0).removeZero) \(detail?.product?.unit?.unit ?? "")"
        lblCultivatorName.text = "\(detail?.cultivator?.firstName ?? "") \(detail?.cultivator?.lastName ?? "")"
        lblItemDescription.text = "\(detail?.product?.description ?? "")"
        imgVwCultivator.setImageOnImageViewServer("\(detail?.cultivator?.imagePath ?? "")", placeholder: UIImage(named: "ic_placeholder")!)
        if ((detail?.cultivator?.cultivator?.rating ?? 0) != 0) || ((detail?.cultivator?.cultivator?.totalReview ?? 0) != 0) {
            lblRating.text = "\(detail?.cultivator?.cultivator?.rating ?? 0)"
            lblReviews.text = "(\(detail?.cultivator?.cultivator?.totalReview ?? 0))"
            imgVwRatingStar.isHidden = false
            cnstWidthImgVwRating.constant = 12
            cnstLeadinglblRating.constant = 5
        } else {
            cnstWidthImgVwRating.constant = 0
            cnstLeadinglblRating.constant = 0
            lblRating.text = ValidationMessages.noReviews
            lblRating.textColor = .gray
            lblReviews.isHidden = true
            imgVwRatingStar.isHidden = true
        }
    }
    
}
