//
//  VirtualCreditsDelegates+Datas.swift
//  Semilla
//
//  Created by Netset on 23/04/24.
//

import UIKit

class VirtualCreditsDataSources: NSObject,UITableViewDataSource {
    
    //MARK: - Variable Declaration
    private var viewModel: VirtualCreditsVM!
    private var properties: VirtualCreditsProperties!
    
    //MARK: - Intializer
    init(viewModel: VirtualCreditsVM, properties: VirtualCreditsProperties) {
        self.viewModel = viewModel
        self.properties = properties
    }
    
    //MARK: - Tableview Datasources Method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.objVirtualCredits.count == 0 {
            properties.vwNoCreditsHistory.isHidden = false
        } else {
            tableView.restore()
            properties.vwNoCreditsHistory.isHidden = true
        }
        return viewModel.objVirtualCredits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCells.creditHistoryTVC) as! CreditHistoryTVC
        let data = viewModel.objVirtualCredits[indexPath.row]
        cell.lblCreditedBy.text = data.description ?? ""
        if (data.credit ?? 0 ) != 0 {
            cell.vwLifetimeCredit.isHidden = false
            cell.creditedAmount.text = "+$\(CommonMethod.shared.convertToColombianPeso(amount: (data.credit ?? 0)) ?? "")"
            cell.creditedAmount.textColor = AppStyle.AppColors.appColorGreen
            cell.vwBackgroundSpentDateTime.backgroundColor = AppStyle.AppColors.receivedDateTime
            if data.expiryDate != nil {
                cell.vwLifetimeCredit.isHidden = true
                cell.lblCreditSpentDateAndTime.textColor = AppStyle.AppColors.appColorGreen
                let formatStr = "\(UTCToLocal(data.createdDate ?? "", backendFormat: DateFormats.UTCFormat1, needFormat: DateFormats.creditsDateFormat))"
                cell.lblCreditSpentDateAndTime.text = "\(ValidationMessages.creditedOn): \(formatStr)"
                cell.vwBackgroundExpiredDateTime.isHidden = false
                let dateFormat = CommonMethod.shared.getTimeFormatInStr(getTime: data.expiryDate ?? "", backendFormat: DateFormats.YYYYMMDD, needTimeFormat: DateFormats.creditExpiredFormat)
                if (dateFormat) < getCurrentDateFormatted(format: DateFormats.creditExpiredFormat) {
                    cell.lblCerditExpiredDateAndTime.text = "\(ValidationMessages.expired): \(dateFormat), 11:59 PM"
                    cell.cnstHeightVwBackgroundExpired.constant = 20
                } else {
                    cell.lblCerditExpiredDateAndTime.text = "\(ValidationMessages.expiredOn): \(dateFormat), 11:59 PM"
                    cell.cnstHeightVwBackgroundExpired.constant = 20
                }
            } else {
                cell.vwLifetimeCredit.isHidden = false
                cell.lblCreditSpentDateAndTime.textColor = AppStyle.AppColors.appColorGreen
                let formatStr = "\(UTCToLocal(data.createdDate ?? "", backendFormat: DateFormats.UTCFormat1, needFormat: DateFormats.creditsDateFormat))"
                cell.lblCreditSpentDateAndTime.text = "\(ValidationMessages.creditedOn): \(formatStr)"
                cell.vwBackgroundExpiredDateTime.isHidden = true
                cell.cnstHeightVwBackgroundExpired.constant = 0
            }
        } else {
            cell.vwLifetimeCredit.isHidden = true
            cell.creditedAmount.text = "-$\(CommonMethod.shared.convertToColombianPeso(amount: (data.debit ?? 0)) ?? "")"
            if data.expiryDate ?? "" == "" {
                let formatStr = "\(UTCToLocal(data.createdDate ?? "", backendFormat: DateFormats.UTCFormat1, needFormat: DateFormats.creditsDateFormat))"
                cell.lblCreditSpentDateAndTime.text = "\(ValidationMessages.spentOn): \(formatStr)"
                cell.creditedAmount.textColor = UIColor.red
                cell.vwBackgroundSpentDateTime.backgroundColor = AppStyle.AppColors.spentDateTime
                cell.vwBackgroundExpiredDateTime.isHidden = true
                cell.cnstHeightVwBackgroundExpired.constant = 0
                cell.lblCreditSpentDateAndTime.textColor = .red
            } else {
                if (data.expiryDate ?? "") < getCurrentDateFormatted(format: DateFormats.creditsDateFormat) {
                    let formatStr = CommonMethod.shared.getTimeFormatInStr(getTime: data.expiryDate ?? "", backendFormat: DateFormats.YYYYMMDD, needTimeFormat: DateFormats.creditExpiredFormat)
                    cell.lblCreditSpentDateAndTime.text = "\(ValidationMessages.expired): \(formatStr), 11:59 PM"
                    cell.creditedAmount.textColor = UIColor.red
                    cell.vwBackgroundSpentDateTime.backgroundColor = AppStyle.AppColors.spentDateTime
                    cell.vwBackgroundExpiredDateTime.isHidden = true
                    cell.cnstHeightVwBackgroundExpired.constant = 0
                    cell.lblCreditSpentDateAndTime.textColor = .red
                } else {
                    let formatStr = CommonMethod.shared.getTimeFormatInStr(getTime: data.expiryDate ?? "", backendFormat: DateFormats.YYYYMMDD, needTimeFormat: DateFormats.creditExpiredFormat)
                    cell.lblCreditSpentDateAndTime.text = "\(ValidationMessages.expiredOn): \(formatStr), 11:59 PM"
                    cell.creditedAmount.textColor = UIColor.red
                    cell.vwBackgroundSpentDateTime.backgroundColor = AppStyle.AppColors.spentDateTime
                    cell.vwBackgroundExpiredDateTime.isHidden = true
                    cell.cnstHeightVwBackgroundExpired.constant = 0
                    cell.lblCreditSpentDateAndTime.textColor = .red
                }
            }
        }
        UIView.animate(withDuration: 0, animations: {
            tableView.layoutIfNeeded()
        }) { complete in
            self.properties.cnstHeightTblVwCreditHistory.constant = self.properties.tblVwCreditHistory.contentSize.height + 40
        }
        return cell
    }
}


class VirtualCreditsDelegates: NSObject,UITableViewDelegate {
    
    //MARK: - Variable Declaration
    private var viewModel: VirtualCreditsVM!
    private var properties: VirtualCreditsProperties!
    
    //MARK: - Intializer
    init(viewModel: VirtualCreditsVM, properties: VirtualCreditsProperties) {
        self.viewModel = viewModel
        self.properties = properties
    }
    
    //MARK: - Delegates Method
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.estimatedRowHeight = 130
            return UITableView.automaticDimension
    }
    
}

class VirtualCreditsScrolling: NSObject,UIScrollViewDelegate {
    
    //MARK: - Variable Declaration
    private var viewModel: VirtualCreditsVM!
    private var properties: VirtualCreditsProperties!
    
    //MARK: - Intializer
    init(viewModel: VirtualCreditsVM, properties: VirtualCreditsProperties) {
        self.viewModel = viewModel
        self.properties = properties
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if ((self.properties.vwScroll.contentOffset.y + self.properties.vwScroll.frame.size.height) >= self.properties.vwScroll.contentSize.height) {
            if (self.viewModel.pageNumber + 1)<(self.viewModel.totalPages) {
                let currentPage = (self.viewModel.pageNumber)
                self.viewModel.pageNumber =  currentPage + 1
                let activityIndicatorii = UIActivityIndicatorView()
                activityIndicatorii.frame = CGRect(x: 0, y: 10, width: 50, height: 50)
                properties.tblVwCreditHistory.tableFooterView = activityIndicatorii
                properties.tblVwCreditHistory.tableFooterView?.isHidden = false
                activityIndicatorii.startAnimating()
                viewModel.creditsHistoryApiMethod(false) {
                    self.properties.tblVwCreditHistory.tableFooterView?.isHidden = true
                    self.properties.tblVwCreditHistory.reloadData()
                    activityIndicatorii.stopAnimating()
                }
            }
        }
    }
}
