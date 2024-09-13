//
//  HomeProperties.swift
//  Semilla
//
//  Created by Netset on 30/11/23.
//

import UIKit

class HomeProperties: UIView {
    
    
    //MARK: IBOutlet's
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var imgVwShoppingCart: UIImageView!
    @IBOutlet weak var btnShoppingCart: UIButton!
    @IBOutlet weak var btnNotifications: UIButton!
    @IBOutlet weak var btnSelectLocation: UIButton!
    @IBOutlet weak var txtFldSearch: UITextField!
    @IBOutlet weak var btnfilter: UIButton!
    @IBOutlet weak var lblCategeory: UILabel!
    @IBOutlet weak var lblRecentlyListed: UILabel!
    @IBOutlet weak var lblBestFarmers: UILabel!
    @IBOutlet weak var colVwCategeory: UICollectionView!
    @IBOutlet weak var colVwRecentlyListed: UICollectionView!
    @IBOutlet weak var colVwBestFarmers: UICollectionView!
    @IBOutlet weak var vwNoItemFound: UIView!
    @IBOutlet weak var lblCartCount: UILabel!
    @IBOutlet weak var vwShoppingCount: UIView!
    @IBOutlet weak var scrollVwHome: UIScrollView!
    @IBOutlet weak var imgVwNotificationIcon: UIImageView!
    @IBOutlet weak var vwNoCultivatorFound: UIView!
    @IBOutlet weak var btnSeeAll: UIButton!
    
    //MARK: VAriable Declaration
    var objHomeDelegates: DelegatesHome?
    
    // MARK: View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        AutoCompleteHelper.shared.getAddressFromCordinates(latitude: Double(userCurrentLat) ?? 0, longitude: Double(userCurrentLong) ?? 0) { address in
            self.lblLocation.text = address.citySelect
        }
        
    }
    
    //MARK: IBAction's
    @IBAction func actionBtnSearch(_ sender: UIButton) {
        self.objHomeDelegates?.gotoSearchHistory()
    }
    
    @IBAction func actionBtnUserLocation(_ sender: UIButton) {        
        self.objHomeDelegates?.gotoAddressPopup()
    }
    
    @IBAction func actionBtnFilter(_ sender: UIButton) {
        self.objHomeDelegates?.gotoFilter()
    }
    
    @IBAction func actionBtnShoppingCart(_ sender: UIButton) {
        self.objHomeDelegates?.gotoShoppingCart()
    }
    
    @IBAction func actionBtnNotifications(_ sender: UIButton) {
        self.objHomeDelegates?.gotoNotifications()
    }
    
    @IBAction func actionBtnSeeAllRecentlyListed(_ sender: UIButton) {
        self.objHomeDelegates?.gotoSeeAllRecentlyItems()
    }
    
    @IBAction func actionBtnSeeAllBestFarmers(_ sender: UIButton) {
        self.objHomeDelegates?.gotoSeeAllCultivatorsList()
    }
    
}
