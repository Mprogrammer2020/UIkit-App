//
//  AboutUsVC.swift
//  Semilla
//
//  Created by Netset on 06/12/23.
//

import UIKit


class AboutUsVC: UIViewController {
    
    //MARK: IBOutlet's
    @IBOutlet var vwProperties: AboutUsProperties!
    
    //MARK: Variable Declaration
    var screenTitle = String()
    var webUrl = String()
    
    //MARK: Viewlife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vwProperties.objAboutUsDelegates = self
        vwProperties.lblAboutUs.text = screenTitle
        self.vwProperties.webVwAboutUs.navigationDelegate = self
        CommonMethod.shared.showActivityIndicator()
        if screenTitle == DisplayNames.termsOfService {
            webUrl = "https://cultivator.semilla.app/terms-condition/\(preferredLang)"
        } else if screenTitle == DisplayNames.privacyPolicy {
            webUrl = "https://cultivator.semilla.app/privacy-policy/\(preferredLang)"
        } else {
            webUrl = preferredLang == "en" ? "https://cultivator.semilla.app/about-us" : "https://cultivator.semilla.app/about-us-spanish"
        }
        if let url = URL(string: webUrl) {
            let request = URLRequest(url: url)
            vwProperties.webVwAboutUs.load(request)
        }
    }
    
}
