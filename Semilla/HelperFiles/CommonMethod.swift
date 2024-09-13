//
//  CommonMethod.swift
//  AIattorney
//
//  Created by netset on 04/07/23.
//

import Foundation
import NVActivityIndicatorView

class CommonMethod {
    
    static var shared: CommonMethod {
        return CommonMethod()
    }
    fileprivate init(){}
    
    
    //MARK: Convert To ColombianPeso
       func convertToColombianPeso(amount: Double) -> String? {
           let amountFormatter = NumberFormatter()
           amountFormatter.numberStyle = .currency
           amountFormatter.currencyCode = "US" // Colombian Peso currency code
           amountFormatter.locale = Locale(identifier: "en") // Colombian Spanish locale
           if let formattedAmount = amountFormatter.string(from: NSNumber(value: amount)) {
               var charArr = Array(formattedAmount)
               charArr.removeFirst()
               let str = String(charArr)
               return str
           } else {
               return nil
           }
       }
    
    
    
    //MARK:- Show Activity Indicator Method
    func showActivityIndicator() {
        DispatchQueue.main.async {
            let activityData = ActivityData()
            NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        }
    }
    
    //MARK:- Hide Activity Indicator Method
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
        }
    }
    
    // MARK: Convert Dictionary To JSON
    func convertDictionaryToJSON(_ dictionary: [String: Any]) -> String? {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted) else {
            return nil
        }
        guard let jsonString = String(data: jsonData, encoding: .utf8) else {
            return nil
        }
        return jsonString
    }
    
    //MARK:- Get String From Date Method
    func getStringFromDate(date: Date,needFormat: String) -> String {
        var dateStr = String()
        if needFormat != "" {
            let formatter = DateFormatter()
            formatter.dateFormat = needFormat
            let locale = Locale.current
            formatter.locale = locale
            dateStr = formatter.string(from: date)
        }
        return dateStr
    }
    
    //MARK:- Get Date From String Method
    func getDateFromSting(string: String,stringFormat: String) -> Date {
        var date = Date()
        if string != "" {
            let formatter = DateFormatter()
            formatter.dateFormat = stringFormat
            let dateInDate = formatter.date(from: string)
            if dateInDate != nil {
                date = dateInDate!
            }
        }
        return date
    }
    
    // MARK: Get Time In String Method
    func getTimeFormatInStr(getTime:String,backendFormat:String,needTimeFormat:String) -> String {
        var resultTimeInStr = String()
        if getTime != "" {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = backendFormat//"yyyy-MM-dd hh:mm a"
            let timeInStr = dateFormatter.date(from: getTime)
            
            let dateFormatter1 = DateFormatter()
            dateFormatter1.dateFormat = needTimeFormat//"yyyy-MM-dd"
            if timeInStr != nil {
                resultTimeInStr = dateFormatter1.string(from: timeInStr!)
            }
        }
        return resultTimeInStr
    }
    
    //MARK: - Navigate to Google Maps
    func showDirectionsOnMap(originLat: Double, originLng: Double, destLat: Double, destLng: Double) {
        if let url = URL(string: "comgooglemaps://?saddr=\(originLat),\(originLng)&daddr=\(destLat),\(destLng)&directionsmode=driving&navigate=yes") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("Google Maps is not installed.")
            Alerts.shared.showAlert(title: AlertMessages.appName, message: "Google Maps is not installed.")
            // Alternatively, you could prompt the user to install Google Maps from the App Store
        }
    }
    
}

