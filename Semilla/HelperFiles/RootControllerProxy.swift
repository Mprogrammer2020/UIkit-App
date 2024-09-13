//
//  RootControllerProxy.swift
//  AIattorney
//
//  Created by netset on 03/07/23.
//

import UIKit

class RootControllerProxy {
    
    static var shared: RootControllerProxy {
        return RootControllerProxy()
    }
    
    fileprivate init(){}
    
    // MARK: Set Root Without Drawer Method
    func rootWithoutDrawer(_ identifier: String,storyboard: Storyboards) {
        let blankController = getStoryboard(storyboard).instantiateViewController(withIdentifier: identifier)
        var homeNavController:UINavigationController = UINavigationController()
        homeNavController = UINavigationController.init(rootViewController: blankController)
        homeNavController.isNavigationBarHidden = true
        UIApplication.shared.windows.first?.rootViewController = homeNavController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    // MARK: Set Root Without Drawer Method
    func setRootTabbarScreen(_ selectIndex: Int) {
        let blankController = getStoryboard(.home).instantiateViewController(withIdentifier: ViewControllers.tabbarVC) as! TabbarVC
        blankController.selectedIndex = selectIndex
        var homeNavController:UINavigationController = UINavigationController()
        homeNavController = UINavigationController.init(rootViewController: blankController)
        homeNavController.isNavigationBarHidden = true
        UIApplication.shared.windows.first?.rootViewController = homeNavController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
}
