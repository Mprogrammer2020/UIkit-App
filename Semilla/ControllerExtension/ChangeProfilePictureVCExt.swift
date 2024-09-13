//
//  ChangeProfilePictureVCExt.swift
//  Semilla
//
//  Created by netset on 28/12/23.
//

import UIKit

extension ChangeProfilePictureVC: DelegatesChangeProfilePicture {
    
    // MARK: - Button Back Clicked
    func gotoBack() {
        self.dismiss(animated: false)
    }
    
    // MARK: - Button Camera Clicked
    func gotoCamera() {
        self.dismiss(animated: true) {
            self.callBackToOpenCamera?()
        }
    }
    
    // MARK: - Button Gallary Clicked
    func gotoGallary() {
        self.dismiss(animated: true) {
            self.callBackToOpenGallery?()
        }
    }
    
}
