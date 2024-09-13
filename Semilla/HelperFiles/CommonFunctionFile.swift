//
//  CommonFunctionFile.swift
//  AIattorney
//
//  Created by netset on 03/07/23.
//

import UIKit
import GoogleMaps

// MARK: Common Variables
var appDelegateObj = UIApplication.shared.delegate as! AppDelegate
let userdefaultsRef = UserDefaults.standard
var objDriverModel : Driver?
var isShowNotificationCount = Bool()
var arrCartAllData = [CartDetailModel]()
var isGuestUser = Bool()
var backToCurrentVC = Bool()
var preferredLang = "en"
var isOnline = Bool()

// MARK: Get Storyboard
func getStoryboard(_ storyType:Storyboards) -> UIStoryboard {
    return UIStoryboard(name: storyType.rawValue, bundle: nil)
}

// MARK: Get Integer Value
func getIntegerValue(_ value:Any) -> Int {
    var integerValue = Int()
    if let getVal = value as? String {
        if getVal.isNumeric && getVal != "" {
            integerValue = Int(getVal) ?? 0
        }
    } else if let getVal = value as? Int {
        integerValue = getVal
    } else if let getVal = value as? Double {
        integerValue = Int(getVal)
    } else if let getVal = value as? Bool {
        integerValue = getVal ? 1 : 0
    }
    return integerValue
}

// MARK: Get String Value
func getStringValue(_ value:Any) -> String {
    var strValue = String()
    if let getVal = value as? String {
        strValue = getVal
    } else if let getVal = value as? Int {
        strValue = String(getVal)
    } else if let getVal = value as? Double {
        strValue = String(getVal)
    }
    return strValue
}


func isValidEmail(_ testStr:String) -> Bool  {
    let emailRegEx =  "[A-Z0-9a-z._%+-ñÑáéíóúüÁÉÍÓÚÜ]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
    return (testStr.range(of: emailRegEx, options:.regularExpression) != nil)
}

func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
    let phoneRegex = #"^\+(?:[0-9]●?){7,14}[0-9]$"#
    let predicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
    return predicate.evaluate(with: phoneNumber)
}

//MARK:- Check Valid Full Name
func isValidName(_ testStr:String) -> Bool {
    //testStr.count > 0,
    guard testStr.count < 18 else { return false }
    let predicateTest = NSPredicate(format: "SELF MATCHES %@", "^(([^ ]?)(^[a-zA-Z].*[a-zA-Z]$)([^ ]?))$")
    return predicateTest.evaluate(with: testStr)
}


func isValidUrl(url: String) -> Bool {
    let urlRegEx = "((?:http|https)://)?(?:www\\.)(?:.)?[\\w\\d\\-_]+\\.\\w{2,3}(\\.\\w{2})?(/(?<=/)(?:[\\w\\d\\-./_]+)?)?"
    return (url.range(of: urlRegEx, options:.regularExpression) != nil)
}

func isValidPassword(_ testStr:String) -> Bool {
    let password = testStr.trimmingCharacters(in: CharacterSet.whitespaces)
    let passwordRegx = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&<>*~:`-]).{8,}$"
    let passwordCheck = NSPredicate(format: "SELF MATCHES %@",passwordRegx)
    return passwordCheck.evaluate(with: password)
    
}

func appFont(name: String, size: CGFloat) -> UIFont {
    return UIFont(name: name, size: size)!
}

// MARK: ******************** Google Map Common Functions **************
func getCameraPosition(lat:Double,long:Double,zoom:Float) -> GMSCameraPosition {
    let getCamera:GMSCameraPosition = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: zoom)
    return getCamera
}

func getCameraPosition(lat:String,long:String,zoom:Float) -> GMSCameraPosition {
    let getCamera:GMSCameraPosition = GMSCameraPosition.camera(withLatitude: Double(lat) ?? 0, longitude: Double(long) ?? 0, zoom: zoom)
    return getCamera
}

func getLocationCoordinate(lat:Double,long:Double) -> CLLocationCoordinate2D {
    let mapCoordinates = CLLocationCoordinate2DMake(lat, long)
    return mapCoordinates
}

func getLocationCoordinate(lat:String,long:String) -> CLLocationCoordinate2D {
    let mapCoordinates = CLLocationCoordinate2DMake(Double(lat) ?? 0, Double(long) ?? 0)
    return mapCoordinates
}

//MARK:- UTC To Local Convert Method
func UTCToLocal(_ UTCDateString: String,backendFormat:String,needFormat:String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = backendFormat //"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
    dateFormatter.locale = Locale.current
    let UTCDate = dateFormatter.date(from: UTCDateString)
    dateFormatter.timeZone = TimeZone.current
    dateFormatter.dateFormat = needFormat
    if UTCDate != nil {
        let UTCToCurrentFormat = dateFormatter.string(from: UTCDate!)
        return UTCToCurrentFormat
    } else {
        return ""
    }
}

//MARK:- UTC To Local Convert Method
func returnDateFromTimeStr(_ dateTimeStr: String) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMMM dd,yyyy HH:mm:ss" //"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    dateFormatter.locale = Locale.current
    let date = dateFormatter.date(from: dateTimeStr)
    dateFormatter.timeZone = TimeZone.current
    return date ?? Date()
}

func setAllLocalCartDataMethod(_ id: Int,count: Int) {
    if let index = arrCartAllData.firstIndex(where: { $0.cartId == id }) {
        arrCartAllData[index].cartCount = count
    } else {
        let request = CartDetailModel(cartId: id,cartCount: count)
        arrCartAllData.append(request)
    }
}

func saveAllLocalCartDataMethod() {
    arrCartAllData = arrCartAllData.map { (object) in
        var updatedObject = object
        updatedObject.cartCount = 0
        return updatedObject
    }
}

func getCurrentDateFormatted(format: String) -> String {
    let currentDate = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    return dateFormatter.string(from: currentDate)
}

//func popBack(_ nb: Int) {
//    if let viewControllers: [UIViewController] = self.navigationController?.viewControllers {
//        guard viewControllers.count < nb else {
//            self.navigationController?.popToViewController(viewControllers[viewControllers.count - nb], animated: true)
//            return
//        }
//    }
//}

extension Date {
    
    func timeAgoDisplay() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
    }
    
    func getElapsedInterval() -> String {
        let interval = Calendar.current.dateComponents([.year, .month,.weekOfYear, .day, .hour, .minute], from: self, to: Date())
        if let year = interval.year, year > 0 {
            return year == 1 ? "\(year)" + " " + ValidationMessages.yearAgo :
            "\(year)" + " " + ValidationMessages.yearAgo
        } else if let month = interval.month, month > 0 {
            return month == 1 ? "\(month)" + " " + ValidationMessages.monthAgo :
            "\(month)" + " " + ValidationMessages.monthAgo
        } else if let weak = interval.weekOfYear, weak > 0 {
            return weak == 1 ? "\(weak)" + " " + ValidationMessages.weekAgo :
            "\(weak)" + " " + ValidationMessages.weekAgo
        } else if let day = interval.day, day > 0 {
            return day == 1 ? "\(day)" + " " + ValidationMessages.dayAgo :
            "\(day)" + " " + ValidationMessages.dayAgo
        } else if let hour = interval.hour, hour > 0 {
            return hour == 1 ? "\(hour)" + " " + ValidationMessages.hourAgo :
            "\(hour)" + " " + ValidationMessages.hourAgo
        } else if let minuts = interval.minute, minuts > 0 {
            return minuts == 1 ? "\(minuts)" + " " + ValidationMessages.minuteAgo :
            "\(minuts)" + " " + ValidationMessages.minuteAgo
        }  else {
            return ValidationMessages.justNow
        }
    }
}

struct CartDetailModel {
    var cartId = Int()
    var cartCount = Int()
}
