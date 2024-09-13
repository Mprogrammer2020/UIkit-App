//
//  ChangeProfilePictureProperties.swift
//  Semilla
//
//  Created by netset on 28/12/23.
//

import UIKit

class ChangeProfilePictureProperties: UIView {

    //MARK: IBOutlet's
    @IBOutlet weak var vwChooseCameraGallary: UIView!
    @IBOutlet weak var lblChooseFor: UILabel!
    @IBOutlet weak var lblCamera: UILabel!
    @IBOutlet weak var lblGallary: UILabel!
    @IBOutlet weak var imgVwCamera: UIImageView!
    @IBOutlet weak var imgVwGallary: UIImageView!
    @IBOutlet weak var btnCameraClick: UIButton!
    @IBOutlet weak var btnGallaryClick: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    //MARK: Variable Declaration
    var selectedImage: UIImage?
    var objChangeProfilePictureDelegates: DelegatesChangeProfilePicture?
    
    //MARK: IBAction's
    @IBAction func actionBtnCameraClick(_ sender: UIButton) {
        self.objChangeProfilePictureDelegates?.gotoCamera()
    }
    
    @IBAction func actionBtnGallaryClick(_ sender: UIButton) {
        self.objChangeProfilePictureDelegates?.gotoGallary()
    }
    
    @IBAction func actionBtnCancel(_ sender: UIButton) {
        self.objChangeProfilePictureDelegates?.gotoBack()
    }
    
}
