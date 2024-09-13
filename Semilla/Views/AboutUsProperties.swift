//
//  AboutUsProperties.swift
//  Semilla
//
//  Created by Netset on 06/12/23.
//

import UIKit
import WebKit


class AboutUsProperties: UIView {
    
    //MARK: IBOutlet's
    @IBOutlet weak var lblAboutUs: UILabel!
    @IBOutlet weak var webVwAboutUs: WKWebView!
    
    //MARK: Variable Declaration
    var objAboutUsDelegates: DelegatesAboutUs?
    
    // MARK: View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        }

    //MARK: IBAction's
    @IBAction func actionBtnBack(_ sender: UIButton) {
        self.objAboutUsDelegates?.gotoBack()
    }
    
}
