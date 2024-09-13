//
//  CustomCalendarVC.swift
//  Semilla
//
//  Created by netset on 04/01/24.
//

import UIKit

class CustomCalendarVC: UIViewController {
    
    //MARK: IBOutlet's
    @IBOutlet var vwProperties: CustomCalendarProperties!
    
    //MARK: - Variable Declarations
    var callbackToDataShowInTxtFld:((String,String)->())?
    var selectedMonth = String()
    var selectedYear = String()
    
    //MARK: Viewlife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        vwProperties.objDelegateCustomCalendar = self
        vwProperties.showData(selectedMonth, selectedYear: selectedYear)
    }
    
}
