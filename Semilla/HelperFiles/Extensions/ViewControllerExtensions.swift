//
//  ViewControllerExtensions.swift
//  Semilla
//
//  Created by Netset on 14/12/23.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showToast(message : String, font: UIFont, textColor: UIColor) {
        let toastLabel = UILabel(frame: CGRect(x: 15, y: self.view.frame.height - 190, width: self.view.frame.size.width - 30, height: 50))
        toastLabel.backgroundColor =  textColor
        toastLabel.textColor = UIColor.white
        toastLabel.roundCorners = true
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.numberOfLines = 0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveLinear, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
}
