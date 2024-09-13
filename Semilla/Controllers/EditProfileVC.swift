//
//  EditProfileVC.swift
//  Semilla
//
//  Created by Netset on 05/02/24.
//

import UIKit

class EditProfileVC: UIViewController {
    
    //MARK: IBOutlet's
    @IBOutlet var vwProperties: EditProfileProperties!
    
    //MARK: Variable Declaration
    var objViewModel = EditProfileVM()
    var objImagePickerManager:ImagePickerManager?
    
    //MARK: Viewlife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vwProperties.objDelegatesEditProfile = self
        vwProperties.showUserDetailMethod()
        
        congigurePickerPicker()
    }
    
    //MARK: - Configure Picker
    func congigurePickerPicker() {
        let imagePicker = UIImagePickerController()
        objImagePickerManager = ImagePickerManager(controller: self, imgPicker: imagePicker)
        imagePicker.delegate = objImagePickerManager
        objImagePickerManager?.pickImageCallback = { (getImage,getVideo) in
            if getImage != nil {
                self.objViewModel.selectImage = getImage!
                self.vwProperties.imgVwUserImage.image = getImage!
            }
        }
    }
    
}
