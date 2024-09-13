//
//  MapViewVCExt.swift
//  Semilla
//
//  Created by Netset on 15/12/23.
//

import GoogleMaps
import UIKit
import CoreLocation

extension MapViewVC: DelegatesMapView {
    
    // MARK: - Button Click Call To Driver
    func callNumber() {
        if let phoneCallURL = URL(string: "tel://\(objMapViewVM.objOrderDetail?.driver?.phone ?? "")") {
            if (UIApplication.shared.canOpenURL(phoneCallURL)) {
                UIApplication.shared.open(phoneCallURL, options: [:], completionHandler: nil)
            } else {
                Alerts.shared.showAlert(title: AlertMessages.appName, message: AlertMessages.numberIsNotValid)
            }
        } else {
            Alerts.shared.showAlert(title: AlertMessages.appName, message: AlertMessages.noNumberShowing)
        }
    }
    
    // MARK: Button Back Clicked
    func gotoBack() {
        if isCommingFrom == ScreenTypes.OrderDetail {
            self.popViewController(true)
        } else {
            RootControllerProxy.shared.rootWithoutDrawer(ViewControllers.tabbarVC, storyboard: .home)
        }
    }
    
    // MARK: - Button click Order Details
    func goToOrderDetails() {
        if isCommingFrom == ScreenTypes.OrderDetail {
            self.popViewController(true)
        } else {
            let vc = getStoryboard(.checkout).instantiateViewController(withIdentifier: ViewControllers.checkoutVC) as! CheckoutVC
            vc.objViewModel.orderId = objMapViewVM.orderId
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // MARK:
    func goToGoogleMaps() {
        let detail = objMapViewVM.objOrderDetail
        CommonMethod.shared.showDirectionsOnMap(originLat:  objMapViewVM.startLoc.latitude, originLng:  objMapViewVM.startLoc.longitude, destLat: objMapViewVM.endLoc.latitude, destLng: objMapViewVM.endLoc.longitude)
    }
    
}

extension MapViewVC {
    
    // MARK: - Configure Map View
    func configureMapDetail() {
        objMapViewVM.updateMapCount = 0
        let detail = objMapViewVM.objOrderDetail
        objMapViewVM.startLoc = CLLocationCoordinate2D()
        objMapViewVM.endLoc = CLLocationCoordinate2D()
        var markerImage = UIImage()
        self.vwProperties.vwOTP.isHidden = true
        if (detail?.status ?? "") == ScreenTypes.order_Intiated || (detail?.status ?? "") == ScreenTypes.pickup_Confirmation_Pending  || (detail?.status ?? "") == ScreenTypes.searching_Delivery_Partner {
            markerImage = UIImage(named: "ic_Cultivator")!
            objMapViewVM.startLoc = getLocationCoordinate(lat: detail?.cultivator?.latitude ?? 0, long: detail?.cultivator?.longitude ?? 0)
            objMapViewVM.endLoc = getLocationCoordinate(lat: detail?.deliveryAddress?.latitude ?? 0, long: detail?.deliveryAddress?.longitude ?? 0)
        } else if (detail?.status ?? "") == ScreenTypes.pickup_Confirm {
            if (detail?.driver?.latitude ?? 0) != 0 {
                markerImage = UIImage(named: "ic_DriverNew")!
                self.socketSubscribe()
                objMapViewVM.startLoc = getLocationCoordinate(lat: detail?.driver?.latitude ?? 0, long: detail?.driver?.longitude ?? 0)
                objMapViewVM.endLoc = getLocationCoordinate(lat: detail?.cultivator?.latitude ?? 0, long: detail?.cultivator?.longitude ?? 0)
            } else {
                markerImage = UIImage(named: "ic_Cultivator")!
                objMapViewVM.startLoc = getLocationCoordinate(lat: detail?.cultivator?.latitude ?? 0, long: detail?.cultivator?.longitude ?? 0)
                objMapViewVM.endLoc = getLocationCoordinate(lat: detail?.deliveryAddress?.latitude ?? 0, long: detail?.deliveryAddress?.longitude ?? 0)
            }
        } else if (detail?.status ?? "") == ScreenTypes.out_For_Delivery || (detail?.status ?? "") == ScreenTypes.atDeliveryLocation {
            if (detail?.driver?.latitude ?? 0) != 0 {
                markerImage = UIImage(named: "ic_DriverNew")!
                self.socketSubscribe()
                vwProperties.vwDriverAssigned.isHidden = false
                self.vwProperties.vwOTP.isHidden = false
                self.vwProperties.lblOTP.text = "OTP: \(detail?.otp ?? "")"
                objMapViewVM.startLoc = getLocationCoordinate(lat: detail?.driver?.latitude ?? 0, long: detail?.driver?.longitude ?? 0)
                objMapViewVM.endLoc = getLocationCoordinate(lat: detail?.deliveryAddress?.latitude ?? 0, long: detail?.deliveryAddress?.longitude ?? 0)
            } else {
                markerImage = UIImage(named: "ic_Cultivator")!
                objMapViewVM.startLoc = getLocationCoordinate(lat: detail?.cultivator?.latitude ?? 0, long: detail?.cultivator?.longitude ?? 0)
                objMapViewVM.endLoc = getLocationCoordinate(lat: detail?.deliveryAddress?.latitude ?? 0, long: detail?.deliveryAddress?.longitude ?? 0)
            }
        }
        debugPrint("StartLoc:- ",objMapViewVM.startLoc)
        debugPrint("EndLoc:- ",objMapViewVM.endLoc)
        // MARK: User Marker
        objMapViewVM.startMarker = GMSMarker(position: objMapViewVM.startLoc)
        objMapViewVM.startMarker?.icon = markerImage
        objMapViewVM.startMarker?.groundAnchor = CGPoint(x: 0.5, y: 0.5)
        objMapViewVM.startMarker?.appearAnimation = GMSMarkerAnimation.pop
        objMapViewVM.startMarker?.map = vwProperties.mapView
        objMapViewVM.startMarker?.title = "Store"
        // MARK: Cultivator Marker
        objMapViewVM.endMarker = GMSMarker(position: objMapViewVM.endLoc)
        objMapViewVM.endMarker?.icon = UIImage(named: "ic_UserLoc")
        objMapViewVM.endMarker?.map = vwProperties.mapView
        objMapViewVM.endMarker?.title = "My Location"
        WebServices.shared.drawRoute(objMapViewVM.startLoc, objMapViewVM.endLoc) { (route, error) in
            //            let time = Int(route?.time ?? 0)
            //            let (h, m, s) = self.secondsToHoursMinutesSeconds(seconds: Double(time))
            //            debugPrint("\(h) Hours, \(m) Minutes, \(s) Seconds")
            //            self.vwProperties.lblEstimatedTimeMins.text = ""
            //            if h > 0 {
            //                self.vwProperties.lblEstimatedTimeDigit.text = "\(h) hrs, \(m) mins"
            //            } else {
            //                self.vwProperties.lblEstimatedTimeDigit.text = "\(m) mins"
            //            }
            if route == nil {
                //Alerts.shared.showAlert(title: AlertMessages.appName, message: error ?? "")
            } else {
                self.objMapViewVM.mutablePath = GMSMutablePath(fromEncodedPath: route?.polylines ?? "")!
                self.objMapViewVM.polyline = GMSPolyline.init(path: self.objMapViewVM.mutablePath)
                self.objMapViewVM.polyline.strokeWidth = 5.0
                self.objMapViewVM.polyline.strokeColor = UIColor(hexString: "#1B973F")
                self.objMapViewVM.polyline.map = self.vwProperties.mapView
                let bounds = GMSCoordinateBounds(path: self.objMapViewVM.mutablePath)
                self.vwProperties.mapView.animate(with: GMSCameraUpdate.fit(bounds, withPadding: 50.0))
            }
        }
        if (detail?.driver?.latitude ?? 0) != 0 {
            vwProperties.handleSwipeGaustureMethod()
            vwProperties.vwDriverAssigned.isHidden = true
            vwProperties.lblDriverName.text = "\(detail?.driver?.firstName ?? "") \(detail?.driver?.lastName ?? "")"
            vwProperties.imgVwDriverImage.setImageOnImageViewServer((detail?.driver?.imagePath ?? ""), placeholder: UIImage(named: "ic_placeholder")!)
            vwProperties.lblDriverId.text = "\(detail?.driver?.id ?? 0)"
        }
        self.vwProperties.lblEstimatedTimeMins.text = ""
        self.vwProperties.lblEstimatedTimeDigit.text = objMapViewVM.objExtrasETA?.eta ?? ""
    }
    
    // MARK: - Change Timing Seconds to Hours And Minutes
    func secondsToHoursMinutesSeconds(seconds: Double) -> (Int, Int, Int) {
      let (hr,  minf) = modf(seconds / 3600)
      let (min, secf) = modf(60 * minf)
      return (Int(hr), Int(min), Int(60 * secf))
    }
}
