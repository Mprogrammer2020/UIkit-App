//
//  MessageSentVC.swift
//  Semilla
//
//  Created by Netset on 25/01/24.
//

import UIKit

class MessageSentVC: UIViewController {

    //MARK: IBOutlet's
    @IBOutlet var vwProperties: MessageSentProperties!
    
    //MARK: Variable Declaration
    var callbackSubmit:(()->())?
    
    //MARK: Viewlife cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vwProperties.objDelegatesMessageSent = self
    }
    


}
