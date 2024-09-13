//
//  Alerts.swift
//  AIattorney
//
//  Created by netset on 04/07/23.
//

import UIKit

class Alerts {
    
    static let shared = Alerts()
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        let getController = AppInitializers.shared.getCurrentViewController()
        DispatchQueue.main.async {
            if let _ = getController.presentingViewController {
                getController.present(alert, animated: true, completion: nil)
            } else {
                UIWindow.key.rootViewController?.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func alertMessageWithActionOk(title: String, message: String,action:@escaping ()->()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: AlertButtonsTitle.okay, style: .default) { (result : UIAlertAction) -> Void in
            action()
        }
        alert.addAction(action)
        let getController = AppInitializers.shared.getCurrentViewController()
        DispatchQueue.main.async {
            if let _ = getController.presentingViewController {
                getController.present(alert, animated: true, completion: nil)
            } else {
                UIWindow.key.rootViewController?.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func alertMessageWithActionVerify(btnTitle:String,title: String, message: String,action:@escaping ()->()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: btnTitle, style: .default) { (result : UIAlertAction) -> Void in
            action()
        }
        alert.addAction(action)
        let getController = AppInitializers.shared.getCurrentViewController()
        DispatchQueue.main.async {
            if let _ = getController.presentingViewController {
                getController.present(alert, animated: true, completion: nil)
            } else {
                UIWindow.key.rootViewController?.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func alertMessageWithActionOkAndCancel(title: String, message: String,action:@escaping ()->()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let actionOk = UIAlertAction(title: AlertButtonsTitle.okay, style: .default) { (result : UIAlertAction) -> Void in
            action()
        }
        let cancel = UIAlertAction(title: AlertButtonsTitle.cancel, style: .cancel) { (result : UIAlertAction) -> Void in
        }
        alert.addAction(actionOk)
        alert.addAction(cancel)
        let getController = AppInitializers.shared.getCurrentViewController()
        DispatchQueue.main.async {
            if let _ = getController.presentingViewController {
                getController.present(alert, animated: true, completion: nil)
            } else {
                UIWindow.key.rootViewController?.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func alertMessageWithActionOkAndCancelLogin(title: String, message: String,action:@escaping ()->()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let cancel = UIAlertAction(title: AlertButtonsTitle.cancel, style: .default) { (result : UIAlertAction) -> Void in
        }
        let actionOk = UIAlertAction(title: AlertButtonsTitle.login, style: .default) { (result : UIAlertAction) -> Void in
            action()
        }
        alert.addAction(cancel)
        alert.addAction(actionOk)
        let getController = AppInitializers.shared.getCurrentViewController()
        DispatchQueue.main.async {
            if let _ = getController.presentingViewController {
                getController.present(alert, animated: true, completion: nil)
            } else {
                UIWindow.key.rootViewController?.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func alertMessageWithActionOkAndCancelYesNo(title: String, message: String,action:@escaping ()->()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let cancel = UIAlertAction(title: AlertButtonsTitle.no, style: .default) { (result : UIAlertAction) -> Void in
        }
        let actionOk = UIAlertAction(title: AlertButtonsTitle.yes, style: .default) { (result : UIAlertAction) -> Void in
            action()
        }
        alert.addAction(actionOk)
        alert.addAction(cancel)
        let getController = AppInitializers.shared.getCurrentViewController()
        DispatchQueue.main.async {
            if let _ = getController.presentingViewController {
                getController.present(alert, animated: true, completion: nil)
            } else {
                UIWindow.key.rootViewController?.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    // MARK: Open Setting Of App
    func openSettingApp() {
        let settingAlert = UIAlertController(title: ValidationMessages.connectionProblem, message: AlertMessages.noInternetConnection, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: AlertButtonsTitle.cancel, style: UIAlertAction.Style.default, handler: nil)
        settingAlert.addAction(okAction)
        let openSetting = UIAlertAction(title: AlertButtonsTitle.setting, style:UIAlertAction.Style.default, handler:{ (action: UIAlertAction!) in
            let url:URL = URL(string: UIApplication.openSettingsURLString)!
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
                })
            } else {
                guard UIApplication.shared.openURL(url) else {
                    Alerts.shared.showAlert(title: AlertMessages.appName, message: AlertMessages.pleaseReviewyournetworksettings)
                    return
                }
            }
        })
        settingAlert.addAction(openSetting)
        let currentController = UIWindow.key.rootViewController
        DispatchQueue.main.async {
            if let _ = currentController?.presentingViewController {
                currentController?.present(settingAlert, animated: true, completion: nil)
            } else {
                UIWindow.key.rootViewController?.present(settingAlert, animated: true, completion: nil)
            }
        }
    }
    
}
