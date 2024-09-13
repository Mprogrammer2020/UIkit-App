//
//  WebServices.swift
//  AIattorney
//
//  Created by netset on 04/07/23.
//

import UIKit
import Alamofire
import GoogleMaps

class WebServices {
    
    static var shared: WebServices {
        return WebServices()
    }
    fileprivate init(){}
    
    //MARK:- App Header
    func headers() -> [String:String] {
        var headersVal = [
            Param.accept:Param.appJson,
            Param.deviceId:Constants.AppInfo.DeviceId,
            Param.deviceType:Param.ios,
            Param.appVersion:Constants.AppInfo.appVersion,
            Param.deviceToken:deviceTokenSaved,
            Param.contentType:Param.appJson,
            Param.role: Param.user,
            Param.acceptLanguage: preferredLang
        ]
        if accessTokenSaved != "" {
            headersVal[Param.auth] = "Bearer \(accessTokenSaved)"
        }
        return headersVal
    }
    
    func isInternetWorking() -> Bool {
        if NetworkReachabilityManager()!.isReachable {
            return true
        } else {
            return false
        }
    }
    
    //MARK: - Post Data API Without Version Update
    func postDataWithoutVersionUpdate(_ urlStr: String, params: [String:Any], showIndicator: Bool,methodType: HTTPMethod,completion: @escaping (_ response: ResponseHandle) -> Void) {
        if NetworkReachabilityManager()!.isReachable {
            if showIndicator {
                CommonMethod.shared.showActivityIndicator()
            }
            debugPrint("URL:- ",urlStr)
            debugPrint("Params:- ", params)
            debugPrint("Headers:- ",headers())
            AF.request(urlStr, method: methodType, parameters: params, encoding: JSONEncoding.default, headers: HTTPHeaders(headers())).responseJSON { response in
                DispatchQueue.main.async {
                    if showIndicator {
                        CommonMethod.shared.hideActivityIndicator()
                    }
                    if response.data != nil && response.error == nil {
                        if let JSON = response.value as? NSDictionary {
                            debugPrint("JSON:- ", JSON)
                            debugPrint("JSON String:- ", NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue) ?? "")
                            if response.response?.statusCode == 200 || response.response?.statusCode == 201 {
                                completion(ResponseHandle(data: response.data!, JSON: JSON, message: self.getErrorMsg(JSON),isSuccess: true))
                            } else if response.response?.statusCode == 401 || response.response?.statusCode == 403  {
                                self.statusHandler(response)
                            } else if response.response?.statusCode == 426 {
                                
                            } else {
                                CommonMethod.shared.hideActivityIndicator()
                                completion(ResponseHandle(data: response.data!, JSON: JSON, message: self.getErrorMsg(JSON), isSuccess: false, statusCode: response.response?.statusCode ?? 204))
                            }
                        } else {
                            CommonMethod.shared.hideActivityIndicator()
                            self.statusHandler(response)
                        }
                    } else {
                        CommonMethod.shared.hideActivityIndicator()
                        self.statusHandler(response)
                    }
                }
            }
        } else {
            CommonMethod.shared.hideActivityIndicator()
            Alerts.shared.openSettingApp()
        }
    }
    
    // MARK: Post Data API Interaction
    func postData(_ urlStr: String, params: [String:Any], showIndicator: Bool,methodType: HTTPMethod,completion: @escaping (_ response: ResponseHandle) -> Void) {
        if NetworkReachabilityManager()!.isReachable {
            if showIndicator {
                CommonMethod.shared.showActivityIndicator()
            }
            debugPrint("URL:- ",urlStr)
            debugPrint("Params:- ", params)
            debugPrint("Headers:- ",headers())
            AF.request(urlStr, method: methodType, parameters: params, encoding: JSONEncoding.default, headers: HTTPHeaders(headers())).responseJSON { response in
                DispatchQueue.main.async {
                    if showIndicator {
                        CommonMethod.shared.hideActivityIndicator()
                    }
                    if response.data != nil && response.error == nil {
                        if let JSON = response.value as? NSDictionary {
                            debugPrint("JSON:- ", JSON)
                            debugPrint("JSON String:- ", NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue) ?? "")
                            if response.response?.statusCode == 200 || response.response?.statusCode == 201 {
                                completion(ResponseHandle(data: response.data!, JSON: JSON, message: self.getErrorMsg(JSON),isSuccess: true))
                            } else if response.response?.statusCode == 401 || response.response?.statusCode == 403  {
                                self.statusHandler(response)
                            } else if response.response?.statusCode == 426 {
                                CommonMethod.shared.hideActivityIndicator()
                                self.statusHandlerWithVersionUpdate(response)
                            } else {
                                CommonMethod.shared.hideActivityIndicator()
                                completion(ResponseHandle(data: response.data!, JSON: JSON, message: self.getErrorMsg(JSON), isSuccess: false, statusCode: response.response?.statusCode ?? 204))
                            }
                        } else {
                            CommonMethod.shared.hideActivityIndicator()
                            self.statusHandler(response)
                        }
                    } else {
                        CommonMethod.shared.hideActivityIndicator()
                        self.statusHandler(response)
                    }
                }
            }
        } else {
            CommonMethod.shared.hideActivityIndicator()
            Alerts.shared.openSettingApp()
        }
    }
    
    // MARK: Get Data API Without Version Update
    func getDataWithoutVersionUpdate(_ urlStr: String, showIndicator: Bool, completion: @escaping(_ response: ResponseHandle) -> Void) {
        if NetworkReachabilityManager()!.isReachable {
            if showIndicator {
                CommonMethod.shared.showActivityIndicator()
            }
            debugPrint("URL:- ",urlStr)
            debugPrint("Headers:- ",headers())
            AF.request(urlStr, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HTTPHeaders(headers())).responseJSON { response in
                DispatchQueue.main.async {
                    if showIndicator {
                        CommonMethod.shared.hideActivityIndicator()
                    }
                    if response.data != nil && response.error == nil {
                        if let JSON = response.value as? NSDictionary {
                            debugPrint("JSON:- ", JSON)
                            debugPrint("JSON String:- ", NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue) ?? "")
                            if response.response?.statusCode == 200 || response.response?.statusCode == 201 {
                                completion(ResponseHandle(data: response.data!, JSON: JSON, message: self.getErrorMsg(JSON),isSuccess: true))
                            } else if response.response?.statusCode == 401 || response.response?.statusCode == 403 {
                                self.statusHandler(response)
                            } else if response.response?.statusCode == 426 {
                                
                            } else {
                                completion(ResponseHandle(data: response.data!, JSON: JSON, message: self.getErrorMsg(JSON),isSuccess: false))
                            }
                        } else {
                            self.statusHandler(response)
                        }
                    } else {
                        debugPrint("Response.error:- ",response.error?.localizedDescription ?? "")
                        self.statusHandler(response)
                    }
                }
            }
        } else {
            CommonMethod.shared.hideActivityIndicator()
            Alerts.shared.openSettingApp()
        }
    }
    
    // MARK: Get Data API Interaction
    func getData(_ urlStr: String, showIndicator: Bool, completion: @escaping(_ response: ResponseHandle) -> Void) {
        if NetworkReachabilityManager()!.isReachable {
            if showIndicator {
                CommonMethod.shared.showActivityIndicator()
            }
            debugPrint("URL:- ",urlStr)
            debugPrint("Headers:- ",headers())
            AF.request(urlStr, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HTTPHeaders(headers())).responseJSON { response in
                DispatchQueue.main.async {
                    if showIndicator {
                        CommonMethod.shared.hideActivityIndicator()
                    }
                    if response.data != nil && response.error == nil {
                        if let JSON = response.value as? NSDictionary {
                            debugPrint("JSON:- ", JSON)
                            debugPrint("JSON String:- ", NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue) ?? "")
                            if response.response?.statusCode == 200 || response.response?.statusCode == 201 {
                                completion(ResponseHandle(data: response.data!, JSON: JSON, message: self.getErrorMsg(JSON),isSuccess: true))
                            } else if response.response?.statusCode == 401 || response.response?.statusCode == 403 {
                                self.statusHandler(response)
                            } else if response.response?.statusCode == 426 {
                                CommonMethod.shared.hideActivityIndicator()
                                self.statusHandlerWithVersionUpdate(response)
                            } else {
                                completion(ResponseHandle(data: response.data!, JSON: JSON, message: self.getErrorMsg(JSON),isSuccess: false))
                            }
                        } else {
                            self.statusHandler(response)
                        }
                    } else {
                        debugPrint("Response.error:- ",response.error?.localizedDescription ?? "")
                        self.statusHandler(response)
                    }
                }
            }
        } else {
            CommonMethod.shared.hideActivityIndicator()
            Alerts.shared.openSettingApp()
        }
    }
    
    
    // MARK: Get Data API Interaction
    func getDataWithHeader(_ urlStr: String,headerDict:[String:String] ,showIndicator: Bool, completion: @escaping(_ response: ResponseHandle) -> Void) {
        if NetworkReachabilityManager()!.isReachable {
            if showIndicator {
                CommonMethod.shared.showActivityIndicator()
            }
            let dictHeader = HTTPHeaders(headerDict)
            debugPrint("URL:- ",urlStr)
            debugPrint("Headers:- ",headerDict)
            AF.request(urlStr, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: dictHeader).responseJSON { response in
                DispatchQueue.main.async {
                    if showIndicator {
                        CommonMethod.shared.hideActivityIndicator()
                    }
                    if response.data != nil && response.error == nil {
                        if let JSON = response.value as? NSDictionary {
                            debugPrint("JSON:- ", JSON)
                            // debugPrint("JSON String:- ", NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue) ?? "")
                            if response.response?.statusCode == 200 || response.response?.statusCode == 201 {
                                completion(ResponseHandle(data: response.data!, JSON: JSON, message: self.getErrorMsg(JSON),isSuccess: true))
                            } else if response.response?.statusCode == 401 || response.response?.statusCode == 403 {
                                self.statusHandler(response)
                            } else if response.response?.statusCode == 426 {
                                CommonMethod.shared.hideActivityIndicator()
                                self.statusHandlerWithVersionUpdate(response)
                            } else {
                                completion(ResponseHandle(data: response.data!, JSON: JSON, message: self.getErrorMsg(JSON),isSuccess: false))
                            }
                        } else {
                            self.statusHandler(response)
                        }
                    } else {
                        debugPrint("Response.error:- ",response.error?.localizedDescription ?? "")
                        self.statusHandler(response)
                    }
                }
            }
        } else {
            CommonMethod.shared.hideActivityIndicator()
            Alerts.shared.openSettingApp()
        }
    }
    
    func uploadMediaFiles(_ urlStr: String,params: [String:AnyObject],docParam:[String:Data],paramDoc:[String:[Data]],imageParam:[String:UIImage],videoParam:[String:URL],showIndicator: Bool,methodType: HTTPMethod,completion: @escaping (_ response: ResponseHandle) -> Void) {
        if NetworkReachabilityManager()!.isReachable {
            if showIndicator {
                CommonMethod.shared.showActivityIndicator()
            }
            debugPrint("URL:- ",urlStr)
            debugPrint("Headers:- ",headers())
            debugPrint("Params:- ",params)
            debugPrint("Doc Param:- ",docParam)
            debugPrint("Param Doc:- ",paramDoc)
            debugPrint("Image Param:- ",imageParam)
            debugPrint("Video Param:- ",videoParam)
            AF.upload(multipartFormData: { (multipartFormData) in
                for (key, val) in params {
                    multipartFormData.append(val.data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
                for (key, val) in imageParam {
                    let timeStamp = Date().timeIntervalSince1970 * 1000
                    let fileName = "image\(timeStamp).png"
                    guard let imageData = val.jpegData(compressionQuality: 0.2) else {
                        return
                    }
                    multipartFormData.append(imageData, withName: key, fileName: fileName , mimeType: "image/png")
                }
                for (key, value) in videoParam {
                    let timeStamp = Date().timeIntervalSince1970 * 1000
                    let fileName = "video\(timeStamp).mp4"
                    multipartFormData.append(value, withName: key, fileName: fileName, mimeType: "video/mp4")
                }
                for (key, value) in docParam {
                    let timeStamp = Date().timeIntervalSince1970 * 1000
                    let fileName = "pdfFile\(timeStamp).pdf"
                    multipartFormData.append(value, withName: key, fileName: fileName, mimeType:"application/pdf")
                }
                for (key, arrValues) in paramDoc {
                    for i in 0..<arrValues.count {
                        let timeStamp = Date().timeIntervalSince1970 * 1000
                        let fileName = "pdfFile\(timeStamp)\(i).pdf"
                        multipartFormData.append(arrValues[i], withName: key, fileName: fileName, mimeType:"application/pdf")
                    }
                }
            },to: urlStr,method: methodType, headers: HTTPHeaders(headers())).responseJSON { response in
                DispatchQueue.main.async {
                    if showIndicator {
                        CommonMethod.shared.hideActivityIndicator()
                    }
                    if response.data != nil && response.error == nil {
                        if let JSON = response.value as? NSDictionary {
                            debugPrint("JSON:- ", JSON)
                            if response.response?.statusCode == 200 || response.response?.statusCode == 201 {
                                completion(ResponseHandle(data: response.data!, JSON: JSON, message: self.getErrorMsg(JSON),isSuccess: true))
                            } else if response.response?.statusCode == 401 || response.response?.statusCode == 403 {
                                self.statusHandler(response)
                            } else {
                                completion(ResponseHandle(data: response.data!, JSON: JSON, message: self.getErrorMsg(JSON),isSuccess: false))
                            }
                        } else {
                            self.statusHandler(response)
                        }
                    } else {
                        if response.data != nil {
                            debugPrint("JSON Error:- ", NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue) ?? "")
                        }
                        debugPrint("Response.error:- ",response.error?.localizedDescription ?? "")
                        self.statusHandler(response)
                    }
                }
            }
        } else {
            CommonMethod.shared.hideActivityIndicator()
            Alerts.shared.openSettingApp()
        }
    }
    
    
    //MARK:- Route Draw API Interaction
    func drawRoute(_ sourceLoc : CLLocationCoordinate2D, _ destinationLoc : CLLocationCoordinate2D, _ wayPointArray : [CLLocationCoordinate2D] = [CLLocationCoordinate2D](), completion: @escaping ( _ route : (polylines : String?, distance: Int?, time: Int?)? , _ error : String? ) -> Void) {
        let waypoints = wayPointArray.map {"\($0.latitude),\($0.longitude)"}.joined(separator: "|")
                let routeUrl = "https://maps.googleapis.com/maps/api/directions/json?" + "origin=\(sourceLoc.latitude),\(sourceLoc.longitude)&destination=\(destinationLoc.latitude),\(destinationLoc.longitude)&waypoints=\(waypoints)&key=\(AppKeys.GoogleInfo.googleKey)"
        
        //debugPrint("RouteUrl:- ",routeUrl)
        if NetworkReachabilityManager()!.isReachable {
            AF.request(routeUrl, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
                if response.response?.statusCode == 200 {
                    guard let JSONDIC = response.value as? NSDictionary else {
                        completion(nil, "")
                        return
                    }
                    //debugPrint("JSONDIC:- ",JSONDIC)
                    guard let getResults = JSONDIC["routes"] as? NSArray else {
                        completion(nil, JSONDIC["error_message"] as? String ?? "")
                        return
                    }
                    if getResults.count > 0  {
                        let getRouteDict = getResults.lastObject as! NSDictionary
                        guard let polyline = getRouteDict.value(forKeyPath: "overview_polyline.points") as? String else {
                            completion(nil, JSONDIC["error_message"] as? String ?? "")
                            return
                        }
                        var distance = Int()
                        var time  = Int()
                        if let legsArr = getRouteDict["legs"] as? NSArray {
                            for index in 0..<legsArr.count {
                                let legDic = legsArr[index] as! NSDictionary
                                if let distVal = legDic.value(forKeyPath: "distance.value") as? Int {
                                    distance += distVal
                                }
                                if let timeVal = legDic.value(forKeyPath: "duration.value") as? Int {
                                    time += timeVal
                                }
                            }
                        }
                        completion((polyline, max(distance, 1000), max(time, 60)), nil)
                    } else {
                        completion(nil, JSONDIC["error_message"] as? String ?? "")
                    }
                }
            }
        } else {
            CommonMethod.shared.hideActivityIndicator()
            Alerts.shared.openSettingApp()
        }
    }
    
    // MARK: Error Handling Methos
    func statusHandler(_ response:AFDataResponse<Any>) {
        CommonMethod.shared.hideActivityIndicator()
        var messageStr = String()
        if let code = response.response?.statusCode {
            if let JSON = response.value as? NSDictionary {
                messageStr = getErrorMsg(JSON)
                debugPrint("Error :- ",messageStr)
                switch code {
                case 400:
                    Alerts.shared.showAlert(title: AlertMessages.appName, message: messageStr)
                case 401:
                    Alerts.shared.alertMessageWithActionOk(title: AlertMessages.appName, message: AlertMessages.sessionExpire) {
                        DispatchQueue.main.async {
                            accessTokenSaved = ""
                            loginUserDetail = nil
                            primaryAddressSaved = nil
                            UINavigationController().viewControllers = []
                            RootControllerProxy.shared.rootWithoutDrawer(ViewControllers.loginVC, storyboard: .main)
                        }
                    }
                case 403:
                    Alerts.shared.alertMessageWithActionOk(title: AlertMessages.appName, message: messageStr) {
                        DispatchQueue.main.async {
                            accessTokenSaved = ""
                            loginUserDetail = nil
                            primaryAddressSaved = nil
                            UINavigationController().viewControllers = []
                            RootControllerProxy.shared.rootWithoutDrawer(ViewControllers.loginVC, storyboard: .main)
                        }
                    }
                default:
                    Alerts.shared.showAlert(title: AlertMessages.appName, message: messageStr)
                }
            } else {
                if response.data != nil {
                    messageStr = (NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue) ?? "") as String
                    messageStr = messageStr == "" ? AlertMessages.serverNotResponding : messageStr
                } else {
                    if response.error != nil {
                        messageStr = response.error?.localizedDescription ?? AlertMessages.serverNotResponding
                    } else {
                        messageStr = AlertMessages.serverNotResponding
                    }
                }
                debugPrint("Error :- ",messageStr)
                if let code = response.response?.statusCode {
                    switch code {
                    case 400:
                        Alerts.shared.showAlert(title: AlertMessages.appName, message: messageStr)
                    case 401:
                        Alerts.shared.alertMessageWithActionOk(title: AlertMessages.appName, message: AlertMessages.sessionExpire) {
                            DispatchQueue.main.async {
                                accessTokenSaved = ""
                                loginUserDetail = nil
                                primaryAddressSaved = nil
                                UINavigationController().viewControllers = []
                                RootControllerProxy.shared.rootWithoutDrawer(ViewControllers.loginVC, storyboard: .main)
                            }
                        }
                    case 403:
                        Alerts.shared.alertMessageWithActionOk(title: AlertMessages.appName, message: messageStr) {
                            DispatchQueue.main.async {
                                accessTokenSaved = ""
                                loginUserDetail = nil
                                primaryAddressSaved = nil
                                UINavigationController().viewControllers = []
                                RootControllerProxy.shared.rootWithoutDrawer(ViewControllers.loginVC, storyboard: .main)
                            }
                        }
                    default:
                        Alerts.shared.showAlert(title: AlertMessages.appName, message: messageStr)
                    }
                } else {
                    Alerts.shared.showAlert(title: AlertMessages.appName, message: messageStr)
                }
            }
        } else {
            if response.data != nil {
                messageStr = (NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue) ?? "") as String
                messageStr = messageStr == "" ? AlertMessages.serverNotResponding : messageStr
            } else {
                if response.error != nil {
                    messageStr = response.error?.localizedDescription ?? AlertMessages.serverNotResponding
                } else {
                    messageStr = AlertMessages.serverNotResponding
                }
            }
            debugPrint("Error :- ",messageStr)
            Alerts.shared.showAlert(title: AlertMessages.appName, message: messageStr)
        }
    }
    
    // MARK: Get Error Message
    func getErrorMsg(_ json: NSDictionary) -> String {
        var msgStr = String()
        if let errorMsg = json["error"] as? String {
            msgStr = errorMsg
        } else if let errorMessage = json["message"] as? String {
            msgStr = errorMessage
        } else if let errorMessage = json["detail"] as? String {
            msgStr = errorMessage
        } else {
            msgStr = AlertMessages.serverNotResponding
        }
        return msgStr
    }
    
    
    func statusHandlerWithVersionUpdate(_  response:AFDataResponse<Any>) {
        CommonMethod.shared.hideActivityIndicator()
        var messageStr = String()
        if let code = response.response?.statusCode {
            if let JSON = response.value as? NSDictionary {
                messageStr = getErrorMsg(JSON)
                debugPrint("Error :- ",messageStr)
                Alerts.shared.alertMessageWithActionVerify(btnTitle: AlertButtonsTitle.update, title: AlertMessages.appName, message: messageStr) {
                    if let url = URL(string: " https://apps.apple.com/us/app/semilla-customer/id6478958518"),
                       UIApplication.shared.canOpenURL(url){
                        UIApplication.shared.open(url, options: [:]) { (opened) in
                            if(opened){
                                print("App Store Opened")
                            }
                        }
                    } else {
                        print("Can't Open URL on Simulator")
                    }
                }
            }
        }
    }
}
