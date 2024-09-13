//
//  AutoCompleteHelper.swift
//  RealZon
//
//  Created by netset on 28/07/22.
//

import UIKit
import CoreLocation
import GooglePlaces

class AutoCompleteHelper: NSObject {
    
    private var pickerCallback : ((AutoCompleteModel) -> ())?;
    static var shared = AutoCompleteHelper()
    var placePicker : GMSAutocompleteViewController!
    var objAutoCompleteModel = AutoCompleteModel()
    
    public func didChoosedLocation(_ ref: UIViewController, _ callback: @escaping ((AutoCompleteModel) -> ())) {
        placePicker =  GMSAutocompleteViewController()
        pickerCallback = callback
        ref.dismissKeyboard()
        UITextField.appearance().backgroundColor = .white
        placePicker.modalPresentationStyle = .overCurrentContext
        placePicker.delegate = self
        ref.present(placePicker, animated: true, completion: nil)
    }
    
    func getAddressFromCordinates(latitude: Double,longitude: Double,onComplete:@escaping ((AutoCompleteModel)->())) {
        debugPrint("Latitude:- ",latitude)
        debugPrint("Longitude:- ",longitude)
        let loc: CLLocation = CLLocation(latitude:latitude, longitude: longitude)
        let ceo: CLGeocoder = CLGeocoder()
        ceo.reverseGeocodeLocation(loc, completionHandler: { (placemarks, error) in
            let objLocationDetail = AutoCompleteModel()
            if (error != nil) {
                Alerts.shared.showAlert(title: AlertMessages.appName, message: error!.localizedDescription)
                return
            }
            if placemarks == nil {
                Alerts.shared.showAlert(title: AlertMessages.appName, message: AlertMessages.errrOccured)
                return
            }
            let pm = placemarks! as [CLPlacemark]
            debugPrint("pm:- ",pm)
            if pm.count > 0 {
                let pm = placemarks![0]
                debugPrint("country",pm.country ?? "")
                debugPrint("locality",pm.locality ?? "")
                debugPrint("subLocality",pm.subLocality ?? "")
                debugPrint("thoroughfare",pm.thoroughfare ?? "")
                debugPrint("postalCode",pm.postalCode ?? "")
                debugPrint("subThoroughfare",pm.subThoroughfare ?? "")
                debugPrint("administrativeArea",pm.administrativeArea ?? "")
                debugPrint("administrativeArea",pm.administrativeArea ?? "")
                var addressString : String = "",shortAddress: String = ""
                if pm.subLocality != nil {
                    addressString = addressString + pm.subLocality! + ", "
                    shortAddress = shortAddress + pm.subLocality! + pm.locality! + ", "
                }
                if pm.subAdministrativeArea != nil {
                    addressString = addressString + pm.subAdministrativeArea! + ", "
                    shortAddress = shortAddress + pm.subAdministrativeArea! + pm.locality!
                }
                if pm.locality != nil {
                    addressString = addressString + pm.locality! + ", "
                }
                if pm.country != nil {
                    addressString = addressString + pm.country! + ", "
                }
                if pm.postalCode != nil {
                    addressString = addressString + pm.postalCode! + " "
                }
                addressString = addressString == "" ? "" :  (addressString.last == " " ? String(addressString.dropLast(1)) : addressString)
                objLocationDetail.latitude = String(latitude)
                objLocationDetail.longitude = String(longitude)
                objLocationDetail.latitudeDouble = latitude
                objLocationDetail.longitudeDouble = longitude
                objLocationDetail.shortAddress = shortAddress
                objLocationDetail.fullAddress = addressString
                objLocationDetail.country = pm.country ?? ""
                objLocationDetail.citySelect = pm.locality ?? ""
                objLocationDetail.state = pm.subThoroughfare ?? ""
                objLocationDetail.zipCode = pm.postalCode ?? ""
                objLocationDetail.street = pm.subLocality ?? ""
                onComplete(objLocationDetail)
            }
        })
    }
}

//MARK: AUTOCOMPLETE DELEGATE(S)
extension AutoCompleteHelper : GMSAutocompleteViewControllerDelegate {

    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        UITextField.appearance().backgroundColor = nil
        objAutoCompleteModel = AutoCompleteModel()
        objAutoCompleteModel.latitude = String(place.coordinate.latitude)
        objAutoCompleteModel.longitude = String(place.coordinate.longitude)
        objAutoCompleteModel.latitudeDouble = place.coordinate.latitude
        objAutoCompleteModel.longitudeDouble = place.coordinate.longitude
        objAutoCompleteModel.shortAddress = place.name ?? ""
        objAutoCompleteModel.fullAddress = place.formattedAddress ?? ""
        if place.addressComponents != nil && place.addressComponents!.count > 0 {
            let arrPlace = place.addressComponents! as NSArray
            for i in 0..<arrPlace.count {
                let dics: GMSAddressComponent = arrPlace[i] as! GMSAddressComponent
                let typeArray = dics.types
                let str = typeArray[0]
                debugPrint("Add:- ",dics.name," = \(str)")
                if str == "administrative_area_level_1" {
                    objAutoCompleteModel.state = "\(dics.name)"
                }
                if str == "locality" {
                    objAutoCompleteModel.citySelect = "\(dics.name)"
                }
                if str == "country" {
                    objAutoCompleteModel.country = "\(dics.name)"
                }
                if str == "postal_code" {
                    objAutoCompleteModel.zipCode = "\(dics.name)"
                }
                if typeArray.contains("street_number") {
                    if dics.name != "" {
                        objAutoCompleteModel.street = "\(dics.name)"
                    }
                }
                if typeArray.contains("premise") {
                    if dics.name != "" {
                        objAutoCompleteModel.street = objAutoCompleteModel.street + "\(dics.name)"
                    }
                }
                if typeArray.contains("route") {
                    if dics.name != "" {
                        objAutoCompleteModel.street = objAutoCompleteModel.street + "\(dics.name)"
                    }
                }
            }
        }
        placePicker.dismiss(animated: true, completion: nil)
        pickerCallback?(objAutoCompleteModel)
    }

    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        UITextField.appearance().backgroundColor = nil
        placePicker.dismiss(animated: true)
    }

    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        UITextField.appearance().backgroundColor = nil
        placePicker.dismiss(animated: true)
    }

}

class AutoCompleteModel {
    
    var latitude = String(),
        longitude = String(),
        placeID = String(),
        shortAddress = String(),
        fullAddress = String(),
        street = String(),
        citySelect = String(),
        country = String(),
        zipCode = String(),
        state = String(),
        latitudeDouble = Double(),
        longitudeDouble = Double()
}
