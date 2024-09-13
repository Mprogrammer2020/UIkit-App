//
//  AppDelegate.swift
//  Semilla
//
//  Created by netset on 29/11/23.
//

import UIKit
import Firebase
import FirebaseMessaging
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var isKillAppNotification = Bool()
    var globalOrderId = Int()
    
    // MARK: - Application Did Launch
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        registerRemoteNotification()
        if let userInfo = launchOptions?[UIApplication.LaunchOptionsKey.remoteNotification] as? [String: AnyObject] {
            isKillAppNotification = true
            //userInfoDict = (userInfo as NSDictionary)
        } else {
            isKillAppNotification = false
        }
        preferredLang = selectedLanguageSaved
        return true
    }
    
    // MARK: - Application Did Become Active
    func applicationDidBecomeActive(_ application: UIApplication) {
        print("applicationDidBecomeActive")
    }
    
    // MARK: - Application in Foreground
    func applicationWillEnterForeground(_ application: UIApplication) {
        print("applicationWillEnterForeground")
        UNUserNotificationCenter.current().getDeliveredNotifications { (userDict) in
            if userDict.count > 0 {
                let userInfoDict = (userDict.first?.request.content.userInfo ?? [:]) as NSDictionary
                print("Pending Notification: ",userInfoDict)
                let orderInfo = userInfoDict["info"] as? String ?? ""
                let dataObj = Data(orderInfo.utf8)
                let apiData = Constants.shared.jsonDecoder.decode(model: PushNotificationModel.self, data: dataObj)
                let currentCont = AppInitializers.shared.getCurrentViewController()
                let orderId = (apiData?.orderId ?? 0)
                if (apiData?.status ?? "") == ScreenTypes.atDeliveryLocation || (apiData?.status ?? "") == ScreenTypes.orderAccept || (apiData?.status ?? "") == ScreenTypes.order_Rejected || (apiData?.status ?? "") == ScreenTypes.pickup_Confirmation_Pending || (apiData?.status ?? "") == ScreenTypes.pickup_Confirm || (apiData?.status ?? "") == ScreenTypes.out_For_Delivery || (apiData?.status ?? "") == ScreenTypes.order_Intiated || (apiData?.status ?? "") == ScreenTypes.searching_Delivery_Partner || (apiData?.status ?? "") == ScreenTypes.orderTimeOut {
                    DispatchQueue.main.async {
                        if currentCont.isKind(of: CheckoutVC.self) || currentCont.isKind(of: MapViewVC.self) {
                            if self.globalOrderId == (apiData?.orderId ?? 0) {
                                delegatePushNotification?.handlePushNotification(apiData?.orderId ?? 0)
                            }
                        } else {
//                            let vc = getStoryboard(.checkout).instantiateViewController(withIdentifier: ViewControllers.checkoutVC) as! CheckoutVC
//                            vc.objViewModel.orderId = orderId
//                            currentCont.navigationController?.pushViewController(vc, animated: true)
                        }
                    }
                } else if (apiData?.status ?? "") == ScreenTypes.virtualCredits || (apiData?.status ?? "") == ScreenTypes.order_Cancelled {
                    DispatchQueue.main.async {
                        if currentCont.isKind(of: VirtualCreditsVC.self) {
                            delegatePushNotification?.handlePushNotification(0)
                        } else {
                            let vc = getStoryboard(.checkout).instantiateViewController(withIdentifier: ViewControllers.virtualCreditsVC) as! VirtualCreditsVC
                            currentCont.navigationController?.pushViewController(vc, animated: true)
                        }
                    }
                } else if (apiData?.status ?? "") == ScreenTypes.order_Delievered || (apiData?.status ?? "") == ScreenTypes.delivered {
                    DispatchQueue.main.async {
                        if currentCont.isKind(of: CheckoutVC.self) || currentCont.isKind(of: MapViewVC.self) {
                            let vc = getStoryboard(.checkout).instantiateViewController(withIdentifier: ViewControllers.orderSuccessfullyDeliveredVC) as! OrderSuccessfullyDeliveredVC
                            vc.callbackToOkay = {
                                if (objDriverModel?.id ?? 0) != 0 {
                                    let vc = getStoryboard(.checkout).instantiateViewController(withIdentifier: ViewControllers.driverReviewVC) as! DriverReviewVC
                                    vc.objDriverReviewVM.orderId = orderId
                                    vc.objDriverReviewVM.objDriver = objDriverModel
                                    vc.objDriverReviewVM.isBackToNotify = true
                                    currentCont.navigationController?.pushViewController(vc, animated: true)
                                } else {
                                    CommonApis.shared.getOrderDetailInfoApiMethod(orderId) {
                                        let vc = getStoryboard(.checkout).instantiateViewController(withIdentifier: ViewControllers.driverReviewVC) as! DriverReviewVC
                                        vc.objDriverReviewVM.orderId = orderId
                                        vc.objDriverReviewVM.objDriver = objDriverModel
                                        vc.objDriverReviewVM.isBackToNotify = true
                                        currentCont.navigationController?.pushViewController(vc, animated: true)
                                    }
                                }
                            }
                            currentCont.present(vc, animated: true)
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Notification Handling

extension AppDelegate: MessagingDelegate {
    
    
    func registerRemoteNotification() {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: { granted, error in
                })
        } else {
            let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
        }
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        debugPrint("FcmToken:- ",fcmToken ?? "")
        deviceTokenSaved = "\(fcmToken ?? "")"
        CommonApis.shared.updateDeviceTokenApi()
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        debugPrint("Unable to register for remote notifications: \(error.localizedDescription)")
    }
}

extension AppDelegate:UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo as [AnyHashable : Any]
        let userInfoDict = (userInfo as NSDictionary)
        debugPrint("user Info Did Receive:- ",userInfoDict)
        if !isKillAppNotification {
            handlePushNotification(userInfoDict)
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.handlePushNotification(userInfoDict)
            }
        }
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,willPresent notification: UNNotification,withCompletionHandler completionHandler: @escaping(UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo as [AnyHashable : Any]
        let userInfoDict = (userInfo as NSDictionary)
        debugPrint("user Info:- ",userInfoDict)
        let currentCont = AppInitializers.shared.getCurrentViewController()
        let orderInfo = userInfoDict["info"] as? String ?? ""
        let dataObj = Data(orderInfo.utf8)
        let apiData = Constants.shared.jsonDecoder.decode(model: PushNotificationModel.self, data: dataObj)
        let orderId = (apiData?.orderId ?? 0)
        isShowNotificationCount = true
        if (apiData?.status ?? "") == ScreenTypes.atDeliveryLocation || (apiData?.status ?? "") == ScreenTypes.orderAccept || (apiData?.status ?? "") == ScreenTypes.order_Rejected || (apiData?.status ?? "") == ScreenTypes.pickup_Confirm || (apiData?.status ?? "") == ScreenTypes.out_For_Delivery || (apiData?.status ?? "") == ScreenTypes.order_Intiated || (apiData?.status ?? "") == ScreenTypes.searching_Delivery_Partner || (apiData?.status ?? "") == ScreenTypes.orderTimeOut {
            if currentCont.isKind(of: CheckoutVC.self) || currentCont.isKind(of: MapViewVC.self) {
                if self.globalOrderId == (apiData?.orderId ?? 0) {
                    delegatePushNotification?.handlePushNotification(apiData?.orderId ?? 0)
                }
            }
            completionHandler([.alert, .sound])
        } else if (apiData?.status ?? "") == ScreenTypes.virtualCredits || (apiData?.status ?? "") == ScreenTypes.order_Cancelled {
            if currentCont.isKind(of: VirtualCreditsVC.self) {
                delegatePushNotification?.handlePushNotification(0)
            }
            completionHandler([.alert, .sound])
        } else if (apiData?.status ?? "") == ScreenTypes.order_Delievered || (apiData?.status ?? "") == ScreenTypes.delivered {
            if currentCont.isKind(of: CheckoutVC.self) || currentCont.isKind(of: MapViewVC.self) {
                let vc = getStoryboard(.checkout).instantiateViewController(withIdentifier: ViewControllers.orderSuccessfullyDeliveredVC) as! OrderSuccessfullyDeliveredVC
                vc.callbackToOkay = {
                    if (objDriverModel?.id ?? 0) != 0 {
                        let vc = getStoryboard(.checkout).instantiateViewController(withIdentifier: ViewControllers.driverReviewVC) as! DriverReviewVC
                        vc.objDriverReviewVM.orderId = orderId
                        vc.objDriverReviewVM.objDriver = objDriverModel
                        vc.objDriverReviewVM.isBackToNotify = true
                        currentCont.navigationController?.pushViewController(vc, animated: true)
                    } else {
                        CommonApis.shared.getOrderDetailInfoApiMethod(orderId) {
                            let vc = getStoryboard(.checkout).instantiateViewController(withIdentifier: ViewControllers.driverReviewVC) as! DriverReviewVC
                            vc.objDriverReviewVM.orderId = orderId
                            vc.objDriverReviewVM.objDriver = objDriverModel
                            vc.objDriverReviewVM.isBackToNotify = true
                            currentCont.navigationController?.pushViewController(vc, animated: true)
                        }
                    }
                }
                currentCont.present(vc, animated: true)
                completionHandler([.alert, .sound])
            } else {
                completionHandler([.alert, .sound])
            }
        } else {
            completionHandler([.alert, .sound])
        }
    }
    
    func handlePushNotification(_ userInfoDict: NSDictionary) {
        let currentCont = AppInitializers.shared.getCurrentViewController()
        let orderInfo = userInfoDict["info"] as? String ?? ""
        let dataObj = Data(orderInfo.utf8)
        let apiData = Constants.shared.jsonDecoder.decode(model: PushNotificationModel.self, data: dataObj)
        let orderId = (apiData?.orderId ?? 0)
        if (apiData?.status ?? "") == ScreenTypes.atDeliveryLocation || (apiData?.status ?? "") == ScreenTypes.orderAccept || (apiData?.status ?? "") == ScreenTypes.order_Rejected || (apiData?.status ?? "") == ScreenTypes.pickup_Confirmation_Pending || (apiData?.status ?? "") == ScreenTypes.pickup_Confirm || (apiData?.status ?? "") == ScreenTypes.out_For_Delivery || (apiData?.status ?? "") == ScreenTypes.order_Intiated || (apiData?.status ?? "") == ScreenTypes.searching_Delivery_Partner || (apiData?.status ?? "") == ScreenTypes.orderTimeOut {
            if currentCont.isKind(of: CheckoutVC.self) || currentCont.isKind(of: MapViewVC.self) {
                if self.globalOrderId == (apiData?.orderId ?? 0) {
                    delegatePushNotification?.handlePushNotification(apiData?.orderId ?? 0)
                } else {
                    let vc = getStoryboard(.checkout).instantiateViewController(withIdentifier: ViewControllers.checkoutVC) as! CheckoutVC
                    vc.objViewModel.orderId = orderId
                    currentCont.navigationController?.pushViewController(vc, animated: true)
                }
            } else {
                let vc = getStoryboard(.checkout).instantiateViewController(withIdentifier: ViewControllers.checkoutVC) as! CheckoutVC
                vc.objViewModel.orderId = orderId
                currentCont.navigationController?.pushViewController(vc, animated: true)
            }
        } else if (apiData?.status ?? "") == ScreenTypes.virtualCredits || (apiData?.status ?? "") == ScreenTypes.order_Cancelled {
            if currentCont.isKind(of: VirtualCreditsVC.self) {
                delegatePushNotification?.handlePushNotification(0)
            } else {
                DispatchQueue.main.async {
                    let vc = getStoryboard(.checkout).instantiateViewController(withIdentifier: ViewControllers.virtualCreditsVC) as! VirtualCreditsVC
                    currentCont.navigationController?.pushViewController(vc, animated: true)
                }
            }
        } else if (apiData?.status ?? "") == ScreenTypes.order_Delievered || (apiData?.status ?? "") == ScreenTypes.delivered {
            if currentCont.isKind(of: CheckoutVC.self) || currentCont.isKind(of: MapViewVC.self) {
                let vc = getStoryboard(.checkout).instantiateViewController(withIdentifier: ViewControllers.orderSuccessfullyDeliveredVC) as! OrderSuccessfullyDeliveredVC
                vc.callbackToOkay = {
                    if (objDriverModel?.id ?? 0) != 0 {
                        let vc = getStoryboard(.checkout).instantiateViewController(withIdentifier: ViewControllers.driverReviewVC) as! DriverReviewVC
                        vc.objDriverReviewVM.orderId = orderId
                        vc.objDriverReviewVM.objDriver = objDriverModel
                        vc.objDriverReviewVM.isBackToNotify = true
                        currentCont.navigationController?.pushViewController(vc, animated: true)
                    } else {
                        CommonApis.shared.getOrderDetailInfoApiMethod(orderId) {
                            let vc = getStoryboard(.checkout).instantiateViewController(withIdentifier: ViewControllers.driverReviewVC) as! DriverReviewVC
                            vc.objDriverReviewVM.orderId = orderId
                            vc.objDriverReviewVM.objDriver = objDriverModel
                            vc.objDriverReviewVM.isBackToNotify = true
                            currentCont.navigationController?.pushViewController(vc, animated: true)
                        }
                    }
                }
                currentCont.present(vc, animated: true)
            } else {
                let vc = getStoryboard(.checkout).instantiateViewController(withIdentifier: ViewControllers.orderSuccessfullyDeliveredVC) as! OrderSuccessfullyDeliveredVC
                vc.callbackToOkay = {
                    if (objDriverModel?.id ?? 0) != 0 {
                        let vc = getStoryboard(.checkout).instantiateViewController(withIdentifier: ViewControllers.driverReviewVC) as! DriverReviewVC
                        vc.objDriverReviewVM.orderId = orderId
                        vc.objDriverReviewVM.objDriver = objDriverModel
                        vc.objDriverReviewVM.isBackToNotify = true
                        currentCont.navigationController?.pushViewController(vc, animated: true)
                    } else {
                        CommonApis.shared.getOrderDetailInfoApiMethod(orderId) {
                            let vc = getStoryboard(.checkout).instantiateViewController(withIdentifier: ViewControllers.driverReviewVC) as! DriverReviewVC
                            vc.objDriverReviewVM.orderId = orderId
                            vc.objDriverReviewVM.objDriver = objDriverModel
                            vc.objDriverReviewVM.isBackToNotify = true
                            currentCont.navigationController?.pushViewController(vc, animated: true)
                        }
                    }
                }
                currentCont.present(vc, animated: true)
            }
        }
        UIApplication.shared.applicationIconBadgeNumber = 0
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
    
    
    
}

