//
//  SelectAddressMapProperties.swift
//  Semilla
//
//  Created by Netset on 15/12/23.
//

import UIKit
import GoogleMaps
import GooglePlaces

class SelectAddressMapProperties: UIView,GMSMapViewDelegate, UITextFieldDelegate {
    
    //MARK: IBOutlet's
    @IBOutlet weak var lblHeaderSelectAddress: UILabel!
    @IBOutlet weak var txtFldSearchAddress: UITextField!
    @IBOutlet weak var vwSearchAddress: UIView!
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var btnOffice: UIButton!
    @IBOutlet weak var btnOther: UIButton!
    @IBOutlet weak var vwMapLocation: UIView!
    @IBOutlet weak var vwStackData: UIView!
    @IBOutlet weak var cnstHeightVwStack: NSLayoutConstraint! // 55
    @IBOutlet weak var lblBtnText: UILabel!
    @IBOutlet weak var cnstVwSearchAddress: NSLayoutConstraint! // 275
    
    //MARK: Variable Declaration
    var objSelectAddressDelegates: DelegatesSelectAddress?
    private var mapView: GMSMapView!
    var objAddressDetail = AutoCompleteModel()
    var selectedAddressType = String()
    var isSearchFromAuto = Bool()

    // MARK: View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareUI()
        self.txtFldSearchAddress.delegate = self
    }
    
    //MARK: TextFeild Delegate Method
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtFldSearchAddress   {
            AutoCompleteHelper.shared.didChoosedLocation(AppInitializers.shared.getCurrentViewController()) { objAddress in
                self.isSearchFromAuto = true
                self.txtFldSearchAddress.text = objAddress.fullAddress
                self.objAddressDetail = objAddress
                self.mapView.setCameraPosition(lat: objAddress.latitude, long: objAddress.longitude, zoom: 14)
            }
            return false
        }
        return true
    }
    
    //MARK: Custom Function
    func prepareUI() {
        let camera:GMSCameraPosition = GMSCameraPosition.camera(withLatitude: Double(userCurrentLat) ?? 0, longitude: Double(userCurrentLong) ?? 0, zoom: 14)
        mapView = GMSMapView(frame: vwMapLocation.frame, camera: camera)
        vwMapLocation.addSubview(mapView)
        mapView.delegate = self
        mapView.isMyLocationEnabled = false
        AutoCompleteHelper.shared.getAddressFromCordinates(latitude: Double(userCurrentLat) ?? 0, longitude: Double(userCurrentLong) ?? 0) { currentAddress in
            self.txtFldSearchAddress.text = currentAddress.fullAddress
            self.objAddressDetail = currentAddress
        }
    }
   
    //MARK: MapView Delegate Method
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        debugPrint("position",mapView.camera.target)
        if !self.isSearchFromAuto {
            let lat = mapView.camera.target.latitude
            let long = mapView.camera.target.longitude
            AutoCompleteHelper.shared.getAddressFromCordinates(latitude: lat, longitude: long) { (currentAddress) in
                self.txtFldSearchAddress.text = currentAddress.fullAddress
                self.objAddressDetail = currentAddress
            }
        } else {
            self.isSearchFromAuto = false
        }
    }

    //MARK: IBAction's
    @IBAction func actionBtnBack(_ sender: UIButton) {
        self.objSelectAddressDelegates?.gotoBack()
    }
    
    @IBAction func actionBtnHome(_ sender: UIButton) {
        btnHome.borderWidth = 2
        btnHome.borderColor = AppStyle.AppColors.appColorGreen
        
        btnOffice.borderWidth = 0
        btnOffice.borderColor = .clear
        
        btnOther.borderWidth = 0
        btnOther.borderColor = .clear
        
        selectedAddressType = selectedType.home        
    }
    
    @IBAction func actionBtnOffice(_ sender: UIButton) {
        officeBtnSelected()
    }
    
    func officeBtnSelected() {
        btnHome.borderWidth = 0
        btnHome.borderColor = .clear
        
        btnOffice.borderWidth = 2
        btnOffice.borderColor = AppStyle.AppColors.appColorGreen

        btnOther.borderWidth = 0
        btnOther.borderColor = .clear
        selectedAddressType = selectedType.office
    }
    
    @IBAction func actionBtnOther(_ sender: UIButton) {
        btnHome.borderWidth = 0
        btnHome.borderColor = .clear
        
        btnOffice.borderWidth = 0
        btnOffice.borderColor = .clear
        
        btnOther.borderWidth = 2
        btnOther.borderColor = AppStyle.AppColors.appColorGreen
        selectedAddressType = selectedType.other
    }
    
    @IBAction func actionBtnSaveThisLocation(_ sender: Any) {
        self.objSelectAddressDelegates?.locationSaved(objAddressDetail)
    }
    
}
