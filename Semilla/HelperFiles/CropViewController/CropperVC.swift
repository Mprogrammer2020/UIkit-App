//
//  CropperVC.swift
//  RevoDrive
//
//  Created by netset on 12/22/20.
//  Copyright © 2020 Netset. All rights reserved.
//

import Foundation
import UIKit

protocol cropperImageVwDelegate {
    func isImageCropper(image:UIImage?)
}

class CropperVC : NSObject, CropViewControllerDelegate {
    
    var delegateCrop : cropperImageVwDelegate? = nil
    static var sharedInstance = CropperVC()
    var nav_controller : UIViewController?
    
    func cropperViewController(controller:UIViewController,image:UIImage) {
        self.nav_controller = controller
        let vc = CropViewController()
        vc.delegate = self
        vc.image = image
        vc.view.backgroundColor = .black
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .overFullScreen
        self.nav_controller?.present(navController, animated: false, completion: nil)
    }
    
    //Cropped Image delegate
    func cropViewController(_ controller: CropViewController, didFinishCroppingImage image: UIImage) {
        print("Dismiss Controller")
    }
    
    func cropViewController(_ controller: CropViewController, didFinishCroppingImage image: UIImage, transform: CGAffineTransform, cropRect: CGRect) {
        controller.dismiss(animated: true, completion: {
            self.delegateCrop?.isImageCropper(image: image)
        })
    }
    
    func cropViewControllerDidCancel(_ controller: CropViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
