//
//  CustomCalendarProperties.swift
//  Semilla
//
//  Created by netset on 04/01/24.
//

import UIKit

class CustomCalendarProperties: UIView {
    
    //MARK: IBOutlet's
    @IBOutlet weak var vwCalendar: UIView!
    @IBOutlet weak var lblSelectExpiryDate: UILabel!
    @IBOutlet weak var btnOkay: UIButton!
    @IBOutlet weak var customDatePicker: UIPickerView!
    
    //MARK: Variable Declaration
    var objDelegateCustomCalendar: DelegatesCustomCalendar?
    var arrMonths = [(String,String)]()
    var arrYears = [Int]()
    var selectMonth = String()
    var selectYear = String()
    
    // MARK: View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        commonSetup()
        lblSelectExpiryDate.text = AlertMessages.selectExpiryDate
    }
    
    func showData(_ selectedMonth:String, selectedYear:String) {
        selectMonth = selectedMonth
        selectYear = selectedYear
        if selectMonth != "" &&  selectMonth != "0" {
            let currentMonth = Int(selectMonth) ?? 0
            let currentYear = Int(selectYear) ?? 0
            let index = arrYears.firstIndex { $0 == currentYear } ?? 0
            customDatePicker.selectRow(currentMonth - 1, inComponent: 0, animated: false)
            customDatePicker.selectRow(index, inComponent: 1, animated: false)
        } else {
            let currentMonth = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!.component(.month, from: NSDate() as Date)
            customDatePicker.selectRow(currentMonth - 1, inComponent: 0, animated: false)
            selectMonth = "\(self.arrMonths[currentMonth - 1].1)"
            selectYear = "\(arrYears[customDatePicker.selectedRow(inComponent: 1)])"
        }
    }
    
    //MARK: IBAction's
    @IBAction func actionBtnOk(_ sender: UIButton) {
        self.objDelegateCustomCalendar?.gotoBack(selectMonth,selectYear)
    }
    
    @IBAction func actionBtnCancel(_ sender: UIButton) {
        self.objDelegateCustomCalendar?.cancel()
    }
    
}

extension CustomCalendarProperties {
    
    func commonSetup() {
        // population years
        var years: [Int] = []
        if years.count == 0 {
            var year = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!.component(.year, from: NSDate() as Date)
            for _ in 1...15 {
                years.append(year)
                year += 1
            }
        }
        self.arrYears = years
        
        // population months with localized names
        var months: [(String,String)] = []
        var month = 0
    
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: preferredLang)
        for _ in 1...12 {
//            months.append((formatter.shortMonthSymbols[month].capitalized,(month + 1)))
            let monthName = formatter.shortStandaloneMonthSymbols[month].capitalized
            let monthNumber = String(format: "%02d", month + 1)
            months.append((monthName, monthNumber))
            month += 1
        }
        self.arrMonths = months
        customDatePicker.delegate = self
        customDatePicker.dataSource = self
        
    }
}

extension CustomCalendarProperties: UIPickerViewDelegate, UIPickerViewDataSource {
    
    // Mark: UIPicker Delegate / Data Source
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return arrMonths[row].0
        case 1:
            return "\(arrYears[row])"
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return arrMonths.count
        case 1:
            return arrYears.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let month = customDatePicker.selectedRow(inComponent: 0)
        let year = customDatePicker.selectedRow(inComponent: 1)
        debugPrint(arrMonths[month].0)
        debugPrint(arrMonths[month].1)
        debugPrint(arrYears[year])
        selectYear = "\(arrYears[year])"
        
        let calendar = Calendar(identifier: .gregorian)
        let currentDate = Date()
        let yearcurr = calendar.component(.year, from: currentDate)
        let currentMon = calendar.component(.month, from: currentDate)
        
        if let selectedMonthInt = Int(arrMonths[month].1) {
            if yearcurr == arrYears[year] {
                if selectedMonthInt >= currentMon {
                    selectMonth = arrMonths[month].1
                } else {
                    selectMonth = arrMonths[currentMon - 1].1
                    customDatePicker.selectRow(currentMon - 1, inComponent: 0, animated: true)
                }
            } else {
                selectMonth = arrMonths[month].1
            }
        }
    }

    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        if #available(iOS 14.0, *) {
            let height: CGFloat = 0.5
            for subview in pickerView.subviews {
                /* smaller than the row height plus 20 point, such as 40 + 20 = 60*/
                if subview.frame.size.height < 60 {
                    if subview.subviews.isEmpty {
                        let topLineView = UIView()
                        topLineView.frame = CGRect(x: 0.0, y: 0.0, width: subview.frame.size.width, height: height)
                        topLineView.backgroundColor = .clear
                        subview.addSubview(topLineView)
                        let bottomLineView = UIView()
                        bottomLineView.frame = CGRect(x: 0.0, y: subview.frame.size.height - height, width: subview.frame.size.width, height: height)
                        bottomLineView.backgroundColor = .clear
                        subview.addSubview(bottomLineView)
                    }
                }
                subview.backgroundColor = .clear
            }
        }
        var label: UILabel
        if let view = view as? UILabel {
            label = view
        } else {
            label = UILabel()
        }
        label.text = pickerView.delegate?.pickerView?(pickerView, titleForRow: row, forComponent: component)
        label.textAlignment = .center
        label.font = UIFont(name: AppStyle.Fonts.interMedium, size: 20)
        label.backgroundColor = .clear
        label.isOpaque = false
        label.textColor = AppStyle.AppColors.appColorGreen
        return label
    }
    
}
