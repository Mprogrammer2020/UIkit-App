

import UIKit
import CoreLocation

var locationUpdates = Bool()
var locationShareInstance:LocationManager = LocationManager()

class LocationManager: NSObject, CLLocationManagerDelegate , UIAlertViewDelegate {
    
    //MARK:- Variables
    var locationManager = CLLocationManager()
    
    //MARK:- Create Instance
    class func sharedLocationManager() -> LocationManager {
        locationShareInstance = LocationManager()
        return locationShareInstance
    }
    
    // MARK: Start Standard Updates Location Methods
    func startStandardUpdates() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.activityType = .automotiveNavigation
        locationManager.distanceFilter = 10
        locationManager.pausesLocationUpdatesAutomatically = false
        if (Bundle.main.object(forInfoDictionaryKey: "NSLocationWhenInUseUsageDescription") != nil) {
            locationManager.requestWhenInUseAuthorization()
        }
        locationUpdates = true
        locationManager.startUpdatingLocation()
        locationManager.allowsBackgroundLocationUpdates  = false
    }
    
    // MARK: Stop Standard Updates Location Methods
    func stopStandardUpdate() {
        locationManager.allowsBackgroundLocationUpdates = false
        locationUpdates = false
        locationManager.stopUpdatingLocation()
    }
    
    // MARK: Location Manager Delegate Methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        userCurrentLat = "\(location.coordinate.latitude)"
        userCurrentLong = "\(location.coordinate.longitude)"
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.denied {
            userCurrentLat = ""
            userCurrentLong = ""
            generateAlertToNotifyUser()
            
        } else if status == CLAuthorizationStatus.authorizedAlways || status == CLAuthorizationStatus.authorizedWhenInUse {
            startStandardUpdates()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                //NotificationCenter.default.post(name: Notification.Name(NotificationKeys.updateLication), object: nil, userInfo: nil)
            }
        }
    }
    
    //MARK:- Generate Alert To Notify User
    func generateAlertToNotifyUser() {
        if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.notDetermined {
            let message = AlertMessages.settingPermission
            Alerts.shared.alertMessageWithActionOk(title: AlertButtonsTitle.grantPermissions, message: message) {
                let settingsURL: URL = URL(string: UIApplication.openSettingsURLString)!
                UIApplication.shared.open(settingsURL)
            }
        }
        if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.denied {
            let message = AlertMessages.appNeedsPermission
            Alerts.shared.alertMessageWithActionOk(title: AlertButtonsTitle.grantPermissions, message: message) {
//                let settingsURL: URL = URL(string: UIApplication.openSettingsURLString)!
//                UIApplication.shared.open(settingsURL)
            }
        }
        if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.notDetermined {
            startStandardUpdates()
        }
    }
    
}
var userCurrentLat: String {
    get {
        return userdefaultsRef.object(forKey: UserDefaultsKeys.currentUserLat) as? String ?? ""
    }
    set {
        userdefaultsRef.set(newValue, forKey: UserDefaultsKeys.currentUserLat)
    }
}
var userCurrentLong: String {
    get {
        return userdefaultsRef.object(forKey: UserDefaultsKeys.currentUserLong) as? String ?? ""
    }
    set {
        userdefaultsRef.set(newValue, forKey: UserDefaultsKeys.currentUserLong)
    }
}
