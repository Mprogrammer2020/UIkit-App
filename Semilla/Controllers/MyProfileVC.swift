//
//  MyProfileVC.swift
//  Semilla
//
//  Created by Netset on 06/12/23.
//

import UIKit

class MyProfileVC: UIViewController {
    
    //MARK: IBOutlet's
    @IBOutlet var vwProperties: MyProfileProperties!
    
    var selectedImage = UIImage()
    var objImagePickerManager:ImagePickerManager?
    var objMyProfileVM = MyProfileVM()
    
    //MARK: Viewlife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        vwProperties.objMyProfileDelegate = self
        congigurePickerPicker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupUI()
        CommonMethod.shared.hideActivityIndicator()
    }
    
    // MARK: - Configure Picker
    func congigurePickerPicker() {
        let imagePicker = UIImagePickerController()
        objImagePickerManager = ImagePickerManager(controller: self, imgPicker: imagePicker)
        imagePicker.delegate = objImagePickerManager
        objImagePickerManager?.pickImageCallback = { (getImage,getVideo) in
            if getImage != nil {
                self.selectedImage = getImage!
                self.callApiImageUpload(getImage!)
            }
        }
    }
    
    //MARK: - Setup UI
    func setupUI() {
        callApiToGetUserDetails()
    }

}
