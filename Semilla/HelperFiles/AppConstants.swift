//
//  AppConstants.swift
//  AIattorney
//
//  Created by netset on 04/07/23.
//

import UIKit

final class Constants {
    
    private init() {}
    static let shared = Constants()
    let jsonDecoder = JSONDecoder()
    let jsonEncoder = JSONEncoder()
    
    enum AppInfo {
        static let DeviceType =  "I"
        static let DeviceId =  UIDevice.current.identifierForVendor!.uuidString
        static let appBundleID = Bundle.main.bundleIdentifier ?? "com.app.netset"
        static let appVersion = "1.0" //Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    }
    
}
struct AppStyle {
    
    enum AppColors {
        static let appColorGreen = UIColor(named: "appColorGreen")!
        static let vwColorLightBlue = UIColor(named: "vwColorOtp")!
        static let vwColorLght = UIColor(named: "AppColourLight")!
        static let vwColorWhite = UIColor(named: "appColourWhite")!
        static let borderColor = UIColor(hexString: "#F0F6FF")
        static let spentDateTime = UIColor(hex: "#FF0505",alpha: 0.1)
        static let receivedDateTime = UIColor(hex: "#00A652",alpha: 0.1)
    }
    
    enum Fonts {
        static let interBold = "Inter-Boldd"
        static let interMedium = "Inter-Medium"
        static let interRegular = "Inter-Regular"
        static let interSemiBold = "Inter-SemiBold"
    }
}
