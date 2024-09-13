//
//  ChangeProfilePictureVC.swift
//  Semilla
//
//  Created by netset on 28/12/23.
//

import UIKit

class ChangeProfilePictureVC: UIViewController {

    //MARK: IBOutlet's
    @IBOutlet var vwProperties: ChangeProfilePictureProperties!
    
    //MARK: - Variable Declaration
    var callBackToOpenCamera:(()->())?
    var callBackToOpenGallery:(()->())?
    
    // MARK: Viewlife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vwProperties.objChangeProfilePictureDelegates = self
    }
}
