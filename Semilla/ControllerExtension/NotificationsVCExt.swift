//
//  NotificationsVCExt.swift
//  Semilla
//
//  Created by netset on 11/12/23.
//

import Foundation


extension NotificationsVC: DelegatesNotification{
    
    // MARK: - Button Back Clicked
    func gotoBack() {
        self.popViewController(true)
    }
}
