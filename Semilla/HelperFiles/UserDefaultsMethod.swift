//
//  UserDefaultsMethod.swift
//  AIattorney
//
//  Created by netset on 04/07/23.
//

import Foundation

var accessTokenSaved: String {
    get {
        return UserDefaults.standard.value(forKey: "accessToken") as? String ?? ""
    }
    set {
        UserDefaults.standard.setValue(newValue, forKey: "accessToken")
        UserDefaults.standard.synchronize()
    }
}

var deviceTokenSaved:String {
    set {
        UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.deviceToken)
        UserDefaults.standard.synchronize()
    }
    get {
        return UserDefaults.standard.string(forKey: UserDefaultsKeys.deviceToken) ?? ""
    }
}

var loginUserDetail: User? {
    get {
        return userdefaultsRef.valueData(User.self, forKey: UserDefaultsKeys.userInfo)
    }
    set {
        userdefaultsRef.setData(encodable: newValue, forKey: UserDefaultsKeys.userInfo)
    }
}


var primaryAddressSaved: MyAddressesList? {
    get {
        return userdefaultsRef.valueData(MyAddressesList.self, forKey: UserDefaultsKeys.addressInfo)
    }
    set {
        userdefaultsRef.setData(encodable: newValue, forKey: UserDefaultsKeys.addressInfo)
    }
}

var payuCardId: String {
    get {
        return UserDefaults.standard.value(forKey: "payu_Card_Id") as? String ?? ""
    }
    set {
        UserDefaults.standard.setValue(newValue, forKey: "payu_Card_Id")
        UserDefaults.standard.synchronize()
    }
}

var selectedLanguageSaved: String {
    get {
        return UserDefaults.standard.value(forKey: "select_language") as? String ?? "en"
    }
    set {
        UserDefaults.standard.setValue(newValue, forKey: "select_language")
        UserDefaults.standard.synchronize()
    }
}
