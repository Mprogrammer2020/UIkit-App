//
//  AppInitializers.swift
//  AIattorney
//
//  Created by netset on 03/07/23.
//

import UIKit
import IQKeyboardManagerSwift
import GooglePlaces
import GoogleMaps
import Stripe

final class AppInitializers {
    
    static var shared: AppInitializers {
        return AppInitializers()
    }
    
    private init() {}
    
    //MARK: - Custom Function
    func setupAppThings() {
        setupKeyboard()
        checkIfLogin()
    }
    
    private func setupKeyboard() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.shouldToolbarUsesTextFieldTintColor = false
        GMSPlacesClient.provideAPIKey(AppKeys.GoogleInfo.googleKey)
        GMSServices.provideAPIKey(AppKeys.GoogleInfo.googleKey)
        STPAPIClient.shared.publishableKey = AppKeys.stripeApikey.stripePublishKey
    }
    
    //MARK: - Screen Launch On Login
    func checkIfLogin() {
        if accessTokenSaved == "" {
//            RootControllerProxy.shared.rootWithoutDrawer(ViewControllers.tabbarVC, storyboard: .home)
            RootControllerProxy.shared.rootWithoutDrawer(ViewControllers.welcomeVC, storyboard: .main)
        } else {
            RootControllerProxy.shared.rootWithoutDrawer(ViewControllers.tabbarVC, storyboard: .home)
        }
    }
    
    //MARK: - Current Controller Function
    func getCurrentViewController() -> UIViewController {
        let newVC = UIViewController()
        if let viewController = UIApplication.shared.windows.first?.rootViewController {
            return findTopViewController(viewController: viewController)
        }
        return newVC
    }
    
    
    func findTopViewController(viewController : UIViewController) -> UIViewController {
        if viewController is UINavigationController {
            let controller = viewController as! UINavigationController
            return findTopViewController(viewController: controller.visibleViewController!)
        } else if viewController is UITabBarController {
            let controller = viewController as! UITabBarController
            return findTopViewController(viewController: controller.selectedViewController!)
        }
        return viewController
    }
    
    
}
