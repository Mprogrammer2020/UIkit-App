//
//  CommonstructFile.swift
//  AIattorney
//
//  Created by netset on 04/07/23.
//

import Foundation

struct ValidationResult {
    let success: Bool
    let message: String?
}

struct AppAlert {
    var isSuccess = Bool()
    var messageStr = String()
}

struct ResponseHandle {
    var data = Data(),
        JSON = NSDictionary(),
        message = String(),
        isSuccess = Bool(),
        statusCode = Int()
}

struct CategoryModel {
    var categeoryNames: String?
    var arrItemList = [DataCheck]()
}

struct DataCheck {
    var categeoryNames: String?
    var images: [String]?
    var itemName: String?
    var amountQty: String?
    var userName: String?
    var userImages: String?
    var Rating: String?
    var qty: String?
    var buyCountNumber:Int?
}

struct SelectQuantity {
    var qty:String?
}

struct selectInWeight  {
    var inWeight: [String]?
}

struct NotificationModel {
    var userImage: String?
    var userName: String?
    var notificationMessage: String?
    var notificationsTime: String?
}

struct CardDetails {
    var username: String?
    var lastFourDigit: String?
    var expiryDate: String?
    var cardImage: String?
    var cvv: String?
    var cardType: String?
}

struct MyAddresses {
    var addressType: String?
    var fullAddress: String?
}

struct FilterModel {
    
    var sections: String?
    var rows: [FilterRowData]?
}

struct FilterRowData {
    var nameStr: String?
    var isSelectedVal: Bool?
}

struct UserDefaultsKeys {
    static let userInfo = "UserInfo"
    static let currentUserLat = "user_current_lat"
    static let currentUserLong = "user_current_long"
    static let addressInfo = "addressInfo"
    static let deviceToken = "deviceToken"
    static let notifyCount = "notifyCountSaved"
}

struct CustomerReviewsModel {
    var driverName = String()
    var driverImage = String()
    var reviewTime = String()
    var rating = String()
    var reviewComment = String()
}

struct DateFormats {
    static let ddMMyyy = "dd MMM yyyy"
    static let yyyyMMdd = "yyyy MMM dd"
    static let dmy = "dd/MM/yyyy"
    static let mmmDDYYYY = "MMM dd, yyyy"
    static let hhmma = "hh:mm a"
    static let HHMMSS =  "HH:mm:ss"
    static let HHMM =  "HH:mm"
    static let ymdhmsz =  "yyyy-MM-dd HH:mm:ss zzz"
    static let my =  "MM/yyyy"
    static let YYYYMMDD = "YYYY-MM-dd"
    static let YYYYMMDDHHMMSS = "yyyy-MM-dd HH:mm:ss"
    static let UTCFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    static let UTCFormat1 = "yyyy-MM-dd'T'HH:mm:ss.SSS"
    static let walletDate = "MM/dd/yyyy hh:mm a"
    static let weekday = "EEEE"
    static let creditExpiredFormat = "dd MMM, yyyy"
    static let creditsDateFormat = "dd MMM, yyyy, hh:mm a"
}
