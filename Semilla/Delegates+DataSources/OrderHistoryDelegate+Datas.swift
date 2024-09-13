//
//  OrderHistoryDelegate+Datas.swift
//  Semilla
//
//  Created by netset on 13/12/23.
//

import UIKit

class OrderHistoryDatasource: NSObject, UITableViewDataSource {
    
    //MARK: Variable Declaration
    private var viewModel: OrderHistoryVM!
    private var orderHistoryProperties: OrderHistoryProperties!
    
    //MARK: Intialization
    init(viewModel: OrderHistoryVM!, orderHistoryProperties: OrderHistoryProperties!) {
        self.viewModel = viewModel
        self.orderHistoryProperties = orderHistoryProperties
    }
    
    //MARK: TableView Datasource Method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if viewModel.arrOrderHistory.count == 0 {
            orderHistoryProperties.vwNoOrderHistoryFound.isHidden = false
        } else {
            orderHistoryProperties.vwNoOrderHistoryFound.isHidden = true
            return viewModel.arrOrderHistory.count
        }
        return viewModel.arrOrderHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = viewModel.arrOrderHistory[indexPath.row]
        let cell = tableView.dequeueReusableCell(indexPath: indexPath) as OrderHistoryListTVC
        cell.imgVwOrders.image = UIImage(named: "ic_orders")
        cell.lblOrderNumber.text = "\(ValidationMessages.order) #\(data.orderId ?? 0)"
        cell.lblOrderPlacedOnDate.text = "\(ValidationMessages.placedOn) \(UTCToLocal(data.orderDate ?? "", backendFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", needFormat: "MMMM dd, yyyy"))"
        cell.lblNumbersOfItems.text = "\(data.totalItems ?? 0)"
        cell.lblOrderPrice.text = "$\(CommonMethod.shared.convertToColombianPeso(amount: (data.totalAmount ?? 0)) ?? "")" // "$\((data.totalAmount ?? 0).addZero)"
        if data.status == ScreenTypes.searching_Delivery_Partner || data.status == ScreenTypes.order_Intiated || data.status == ScreenTypes.pickup_Confirmation_Pending || data.status == ScreenTypes.awaitingPayment {
            cell.lblOrderStatus.text = ValidationMessages.orderPlacedNew
            cell.vwStatusChangeColor.backgroundColor = .systemYellow
            cell.lblOrderStatus.textColor = .systemYellow
            cell.lblOrderPlacedDate.isHidden = true
        }  else if data.status == ScreenTypes.pickUpPartnerVerified || data.status == ScreenTypes.pickup_Confirm || data.status == ScreenTypes.out_For_Delivery {
            cell.lblOrderStatus.text = ValidationMessages.outForDelivery
            cell.vwStatusChangeColor.backgroundColor = .systemOrange
            cell.lblOrderStatus.textColor = .systemOrange
            cell.lblOrderPlacedDate.text = "\(UTCToLocal(data.orderStatusDate ?? "", backendFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", needFormat: "MMMM dd, yyyy"))"
        }  else if data.status == ScreenTypes.order_Delievered || data.status == ScreenTypes.delivered {
            cell.lblOrderStatus.text = ValidationMessages.orderDelivered
            cell.vwStatusChangeColor.backgroundColor = AppStyle.AppColors.appColorGreen
            cell.lblOrderStatus.textColor = AppStyle.AppColors.appColorGreen
            cell.lblOrderPlacedDate.text = "\(UTCToLocal(data.orderStatusDate ?? "", backendFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", needFormat: "MMMM dd, yyyy"))"
        } else if data.status == ScreenTypes.order_Cancelled || data.status == ScreenTypes.orderTimeOut  {
            cell.lblOrderStatus.text = ValidationMessages.orderCanceled
            cell.vwStatusChangeColor.backgroundColor = .red
            cell.lblOrderStatus.textColor = .red
            cell.lblOrderPlacedDate.text = "\(UTCToLocal(data.orderStatusDate ?? "", backendFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", needFormat: "MMMM dd, yyyy"))"
        }  else if data.status == ScreenTypes.reviewed.lowercased() {
            cell.lblOrderStatus.text = "\(data.status ?? "")"
            cell.vwStatusChangeColor.backgroundColor = .systemBlue
            cell.lblOrderStatus.textColor = .systemBlue
            cell.lblOrderPlacedDate.text = "\(UTCToLocal(data.orderStatusDate ?? "", backendFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", needFormat: "MMMM dd, yyyy"))"
        } else if data.status == ScreenTypes.order_Rejected {
            cell.lblOrderStatus.text = ValidationMessages.orderRejected
            cell.vwStatusChangeColor.backgroundColor = .systemRed
            cell.lblOrderStatus.textColor = .systemRed
            cell.lblOrderPlacedDate.text = "\(UTCToLocal(data.orderStatusDate ?? "", backendFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", needFormat: "MMMM dd, yyyy"))"
        } else if data.status == ScreenTypes.atDeliveryLocation {
            cell.lblOrderStatus.text = ValidationMessages.readyToPickup
            cell.vwStatusChangeColor.backgroundColor = .systemIndigo
            cell.lblOrderStatus.textColor = .systemIndigo
            cell.lblOrderPlacedDate.text = "\(UTCToLocal(data.orderStatusDate ?? "", backendFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", needFormat: "MMMM dd, yyyy"))"
        } else {
            cell.lblOrderStatus.text = ""
            cell.vwStatusChangeColor.isHidden = true
        }
        return cell
    }
    
}

//MARK: TableView Delegate Method
class OrderHistoryDelegates: NSObject, UITableViewDelegate {
    
    //MARK: Variable Declaration
    private var viewModel: OrderHistoryVM!
    private var orderHistoryProperties: OrderHistoryProperties!
    var callBackToNavigateOrderHistoryDetails: ((Int,String)->())?
    
    //MARK: Intialization
    init(viewModel: OrderHistoryVM!, orderHistoryProperties: OrderHistoryProperties!) {
        self.viewModel = viewModel
        self.orderHistoryProperties = orderHistoryProperties
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = viewModel.arrOrderHistory[indexPath.row]
        self.callBackToNavigateOrderHistoryDetails?(indexPath.row, data.status ?? "")
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == orderHistoryProperties.tblVwOrderHistoryList {
            if ((self.orderHistoryProperties.tblVwOrderHistoryList.contentOffset.y + self.orderHistoryProperties.tblVwOrderHistoryList.frame.size.height) >= self.orderHistoryProperties.tblVwOrderHistoryList.contentSize.height) {
                if (self.viewModel.pageNumber + 1)<(self.viewModel.totalPages) {
                    let currentPage = (self.viewModel.pageNumber )
                    self.viewModel.pageNumber =  currentPage + 1
                    orderHistoryProperties.tblVwOrderHistoryList.tableFooterView = orderHistoryProperties.activityIndicator
                    orderHistoryProperties.tblVwOrderHistoryList.tableFooterView?.isHidden = false
                    viewModel.orderHistoryApiMethod(false) {
                        self.orderHistoryProperties.tblVwOrderHistoryList.tableFooterView?.isHidden = true
                        self.orderHistoryProperties.tblVwOrderHistoryList.reloadData()
                    }
                }
            }
        }
    }
    
}
