//
//  TabbarVC.swift
//  Semilla
//
//  Created by Netset on 05/12/23.
//

import UIKit

class TabbarVC: UITabBarController {
    
    //MARK: Viewlife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
}

extension TabbarVC: UITabBarControllerDelegate {
    
    // MARK: TabBar Controller Delegate Method
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let index = tabBarController.viewControllers?.firstIndex(of: viewController)
        if index == 3 {
            if isGuestUser == true {
                Alerts.shared.alertMessageWithActionOkAndCancelLogin(title: AlertMessages.appName, message: AlertMessages.performLoginrequired) {
                    self.pushToViewController(storyBoard: .main, Identifier: ViewControllers.loginVC, animated: true)
                }
                return false
            }
            return true
        } else {
            return true
        }
    }
    
}
