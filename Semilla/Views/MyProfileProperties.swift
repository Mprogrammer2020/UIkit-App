//
//  MyProfileProperties.swift
//  Semilla
//
//  Created by Netset on 06/12/23.
//

import UIKit

class MyProfileProperties: UIView {
    
    
    //MARK: IBOutlet's
    @IBOutlet weak var lblHeaderMyProfile: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var imgVwUserProfile: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblUserMobileNumber: UILabel!
    
    //MARK: Variable Declaration
    var selectedImage: UIImage?
    var objMyProfileDelegate: DelegatesMyProfile?
    
    //MARK: IBAction's
    
    @IBAction func actionBtnCameraToChangePicture(_ sender: UIButton) {
        self.objMyProfileDelegate?.gotoChangeProfilePicture()
    }
    
    @IBAction func actionBtnBack(_ sender: UIButton) {
        self.objMyProfileDelegate?.gotoBack()
    }
    
    @IBAction func actionBtnEditProfile(_ sender: UIButton) {
        self.objMyProfileDelegate?.editProfile()
    }
    
    @IBAction func actionBtnAboutUs(_ sender: UIButton) {
        self.objMyProfileDelegate?.gotoAboutUs()
    }
    
    @IBAction func actionBtnOrderHistory(_ sender: UIButton) {
        self.objMyProfileDelegate?.gotoOrderHistory()
    }
    
    @IBAction func actionBtnMyAddress(_ sender: UIButton) {
        self.objMyProfileDelegate?.myAddress()
    }
    
    @IBAction func actionBtnCredits(_ sender: UIButton) {
        self.objMyProfileDelegate?.goToCredits()
    }
    
    @IBAction func actionBtnAboutHelpAndSupport(_ sender: UIButton) {
        self.objMyProfileDelegate?.gotoHelpAndSupport()
    }
    
    @IBAction func actionBtnChangeLanguage(_ sender: UIButton) {
        self.objMyProfileDelegate?.goToChangeLanguage()
    }
    
    @IBAction func actionBtnCreditcards(_ sender: UIButton) {
        self.objMyProfileDelegate?.gotoCreditCards()
    }
    
    @IBAction func actionbtnSignout(_ sender: UIButton) {
        self.objMyProfileDelegate?.signOut()
    }
    
    @IBAction func actionBtnDeleteAccount(_ sender: UIButton) {
        objMyProfileDelegate?.goToDeleteAccount()
    }
}
