//
//  OrderHistoryDetailedDelegate+Datas.swift
//  Semilla
//
//  Created by Netset on 22/12/23.
//

import UIKit

class OrderHistoryDetailedDataSources: NSObject, UITableViewDataSource {
    
    //MARK: Variable Declaration
    private var viewModelOrderHistoryDetailed: OrderHistoryVM!
    private var orderHistoryDetailedProperties: OrderHistoryDetailedProperties!
    
    //MARK: Intialization
    init(viewModelOrderHistoryDetailed: OrderHistoryVM!, orderHistoryDetailedProperties: OrderHistoryDetailedProperties!) {
        self.viewModelOrderHistoryDetailed = viewModelOrderHistoryDetailed
        self.orderHistoryDetailedProperties = orderHistoryDetailedProperties
    }
    
    //MARK: TableView Datasource Method
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModelOrderHistoryDetailed.arrOrderHistory.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModelOrderHistoryDetailed.btnClicks.contains(section) {
            return viewModelOrderHistoryDetailed.arrOrderHistory[section].orderDate?.count ?? 0
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let data = viewModelOrderHistoryDetailed.arrOrderHistory[indexPath.section].orderDate?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCells.orderHistoryStatusTVC, for: indexPath) as! OrderHistoryStatusTVC
//        cell.lblOrderPlacedDate.text = data.orderPlacedDate
//        cell.lblOrderConfirmedDate.text = data.orderConfirmedDate
//        cell.lblOrderShippedDate.text = data.orderShippedDate
//        cell.lblOutForDeliveryDate.text = data.outForDeliveryDate
//        cell.lblOrderDeliveredDate.text = data.orderDeliveredDate
        return cell
    }
    
}


class OrderHistoryDetailedDelegates: NSObject, UITableViewDelegate {
    
    //MARK: Variable Declaration
    private var viewModelOrderHistoryDetailed: OrderHistoryVM!
    private var orderHistoryDetailedProperties: OrderHistoryDetailedProperties!
    
    //MARK: Intialization
    init(viewModelOrderHistoryDetailed: OrderHistoryVM!, orderHistoryDetailedProperties: OrderHistoryDetailedProperties!) {
        self.viewModelOrderHistoryDetailed = viewModelOrderHistoryDetailed
        self.orderHistoryDetailedProperties = orderHistoryDetailedProperties
    }
    
    //MARK: TableView Delegate Method
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let data = viewModelOrderHistoryDetailed.arrOrderHistory[section]
        let header = tableView.dequeueReusableCell(withIdentifier: TableCells.orderHistoryDetailedTVC) as! OrderHistoryDetailedTVC
        header.imgVwOrders.image = UIImage(named: "ic_orders")
        header.lblOrderNumber.text = "Order Id #\(data.orderId ?? 0)"
        header.lblOrderPlacedOnDate.text = "Placed on \(data.orderDate ?? "")"
        header.lblNumbersOfItems.text = "\(data.totalItems ?? 0)"
        header.lblOrderPrice.text = "\(data.totalAmount ?? 0)"
        header.lblOrderStatus.text = "Order \(data.status ?? "")"
        header.lblOrderPlacedDate.text = data.orderStatusDate
        
        if data.status == "Delivered" {
            header.lblOrderStatus.text = "Order \(data.status ?? "")"
            header.vwStatusChangeColor.backgroundColor = AppStyle.AppColors.appColorGreen
            header.lblOrderStatus.textColor = AppStyle.AppColors.appColorGreen
        } else {
            header.lblOrderStatus.text = "Order \(data.status ?? "")"
            header.vwStatusChangeColor.backgroundColor = .red
            header.lblOrderStatus.textColor = .red
        }
        
        header.btnToViewOrderStatus.tag = section
        header.btnToViewOrderStatus.addTarget(self, action: #selector(newAction(_:)), for: .touchUpInside)
        if viewModelOrderHistoryDetailed.btnClicks.contains(section){
            header.btnToViewOrderStatus.setImage(UIImage(named: "ic_List_up"), for: .normal)
        } else {
            header.btnToViewOrderStatus.setImage(UIImage(named: "ic_List_down"), for: .normal)
        }
        return header
    }
    
    @objc func newAction(_ sender: UIButton) {
        if viewModelOrderHistoryDetailed.btnClicks.contains(sender.tag){
            viewModelOrderHistoryDetailed.btnClicks.remove(sender.tag)
        }else{
            viewModelOrderHistoryDetailed.btnClicks.add(sender.tag)
        }
        orderHistoryDetailedProperties.tblVwOrderStatus.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
    
}
