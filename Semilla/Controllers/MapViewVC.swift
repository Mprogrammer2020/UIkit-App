//
//  MapViewVC.swift
//  Semilla
//
//  Created by Netset on 14/12/23.
//

import UIKit
import GoogleMaps
import StompClientLib

class MapViewVC: UIViewController {
    
    //MARK: IBOutlet's
    @IBOutlet var vwProperties: MapViewProperties!
    
    //MARK: Variable Declaration
    var isComingFromHomeScreen = false
    var isCommingFrom = String()
    var objMapViewVM = MapViewVM()
    
    //MARK: Viewlife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if !isCheckSocketConnect {
            SocketIOManager.sharedInstance.connectToServer()
        }
        self.vwProperties.objMapViewDelegates = self
        self.isComing()
        appDelegateObj.globalOrderId = objMapViewVM.orderId
        objMapViewVM.getOrderDetailApiMethod {
            self.configureMapDetail()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        delegatePushNotification = self
    }
    
    //MARK: - On Screen Coming From
    func isComing() {
        if isComingFromHomeScreen == true {
            vwProperties.vwArrivingTime.isHidden = true
        } else {
            vwProperties.vwArrivingTime.isHidden = false
        }
    }
    
    //MARK: - Socket Subscribe
    func socketSubscribe() {
        deledateSocketChat = self
        SocketIOManager.sharedInstance.subscribeChatRoom(urlStr: "/subscribe/location/\(objMapViewVM.orderId)")
    }
    
}
extension MapViewVC: DeledateSocketChat {
    
    // MARK: Handle Socket Response
    func handleSocketResponse(_ dict: NSDictionary) {
        let lat = getStringValue(dict["latitude"] as Any)
        let long = getStringValue(dict["longitude"] as Any)
        let extrasDict = dict["extras"] as? NSDictionary ?? [:]
        let etaTime = getStringValue(extrasDict["eta"] as Any)
        debugPrint("eta",etaTime)
        debugPrint("lat",lat)
        debugPrint("long",long)
        self.vwProperties.lblEstimatedTimeDigit.text = etaTime
        let updateLocation = getLocationCoordinate(lat: lat, long: long)
       // if objMapViewVM.updateMapCount >= 2 {
            objMapViewVM.updateMapCount = 0
            WebServices.shared.drawRoute(updateLocation, objMapViewVM.endLoc) { (route, error) in
                if route == nil {
                    //Alerts.shared.showAlert(title: AlertMessages.appName, message: error ?? "")
                } else {
                    CATransaction.begin()
                    CATransaction.setValue(Int(2.0), forKey: kCATransactionAnimationDuration)
                    self.objMapViewVM.startMarker?.position = updateLocation
                    self.objMapViewVM.startMarker?.groundAnchor = CGPoint(x: 0.5, y: 0.5)
                    self.objMapViewVM.startMarker?.appearAnimation = GMSMarkerAnimation.pop
                    self.objMapViewVM.polyline.map = nil
                    self.objMapViewVM.mutablePath = GMSMutablePath(fromEncodedPath: route?.polylines ?? "")!
                    self.objMapViewVM.polyline = GMSPolyline.init(path: self.objMapViewVM.mutablePath)
                    self.objMapViewVM.polyline.strokeWidth = 5.0
                    self.objMapViewVM.polyline.strokeColor = UIColor(hexString: "#1B973F")
                    self.objMapViewVM.polyline.map = self.vwProperties.mapView
                    self.vwProperties.mapView.camera = getCameraPosition(lat: lat, long: long, zoom: 14)
                    CATransaction.commit()
                }
            }
//        } else {
//            objMapViewVM.updateMapCount = objMapViewVM.updateMapCount + 1
//            CATransaction.begin()
//            CATransaction.setValue(Int(2.0), forKey: kCATransactionAnimationDuration)
//            self.objMapViewVM.startMarker?.position = updateLocation
//            self.objMapViewVM.startMarker?.groundAnchor = CGPoint(x: 0.5, y: 0.5)
//            self.objMapViewVM.startMarker?.appearAnimation = GMSMarkerAnimation.pop
//            CATransaction.commit()
//        }
    }
}

//MARK: - Handle Push Notifications
extension MapViewVC: DelegatePushNotification {
    
    func handlePushNotification(_ orderId: Int) {
        objMapViewVM.getOrderDetailApiMethod {
            self.vwProperties.mapView.clear()
            self.configureMapDetail()
            UIApplication.shared.applicationIconBadgeNumber = 0
            UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        }
    }
}
