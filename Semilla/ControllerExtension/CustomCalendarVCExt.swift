//
//  CustomCalendarVCExt.swift
//  Semilla
//
//  Created by netset on 04/01/24.
//

import Foundation


extension CustomCalendarVC: DelegatesCustomCalendar {
    
    // MARK: Button Back Clicked
    func gotoBack(_ month:String,_ year:String) {
        self.dismiss(animated: true) {
            self.callbackToDataShowInTxtFld?(month,year)
        }
    }
    
    // MARK: - Button Click Cancel
    func cancel() {
        self.dismiss(animated: true)
    }
    
}
