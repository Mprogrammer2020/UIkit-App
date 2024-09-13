//
//  TopSellingProductsDelegate+Datas.swift
//  Semilla
//
//  Created by Netset on 26/12/23.
//

import UIKit

class TopSellingProductsTblVwDatasource: NSObject, UITableViewDataSource {
    
    //MARK: Variable Declaration
    var viewModel: CultivatorsDetailedVM!
    var TopSellingProductsProperties: TopSellingProductsProperties!
    
    //MARK: Intialization
    init(viewModel: CultivatorsDetailedVM!, TopSellingProductsProperties: TopSellingProductsProperties!) {
        self.viewModel = viewModel
        self.TopSellingProductsProperties = TopSellingProductsProperties
    }
    
    //MARK: TableView Datasource Method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if viewModel.topSellingProduct.count == 0 {
//            tableView.setEmptyMessage("")
//        } else {
//            tableView.restore()
//        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCells.shoppingCartTVC, for: indexPath) as! ShoopingCartTVC
//        let data = viewModel.topSellingProduct[indexPath.row]
//        cell.lblItemName.text = data.itemName
//        cell.lblItemPrice.text = data.itemPrice
//        cell.lblItemCategeoryQty.text = data.itemCategoryQty
//        cell.lblItemDiscountPrice.text = data.discountPrice
//        cell.lblQtyNumber.text = data.buyNumber
//        cell.imgVwItem.image = UIImage(named: data.itemImage ?? "")
//        cell.btnIncreaseQty.tag = indexPath.row
//        cell.btnDecreaseQty.tag = indexPath.row
//        cell.btnIncreaseQty.addTarget(self, action: #selector(btnIncrease(_:)), for: .touchUpInside)
//        cell.btnDecreaseQty.addTarget(self, action: #selector(btnDecrease(_:)), for: .touchUpInside)
        return cell
    }
    
    @objc func btnIncrease(_ sender: UIButton) {
//        let indexPathRow = sender.tag
//        let data = viewModel.topSellingProduct[indexPathRow]
//        if let countData = Int(data.buyNumber ?? "") {
//            let newCount = countData + 1
//            viewModel.topSellingProduct[indexPathRow].buyNumber = String(newCount)
//            TopSellingProductsProperties.tblVwAllSellingProductsList.reloadRows(at: [IndexPath(row: indexPathRow, section: 0)], with: .automatic)
//            debugPrint("Updated count:", newCount)
//        } else {
//            debugPrint("Invalid or nil BuyNumber")
//        }
    }
    
    @objc func btnDecrease(_ sender: UIButton) {
//        let index = sender.tag
//        let data = viewModel.topSellingProduct[index]
//        if let countData = Int(data.buyNumber ?? "") {
//            if countData > 1 {
//                let newCount = countData - 1
//                viewModel.topSellingProduct[index].buyNumber = String(newCount)
//                TopSellingProductsProperties.tblVwAllSellingProductsList.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
//                debugPrint("Updated count:", newCount)
//            }
//        } else {
//            debugPrint("Invalid or nil BuyNumber")
//        }
    }
}

//MARK: TableView Delegate Method
class TopSellingProductsTblVwDelegates: NSObject, UITableViewDelegate {
    
    //MARK: Variable Declaration
    var viewModel: CultivatorsDetailedVM!
    var TopSellingProductsProperties: TopSellingProductsProperties!
    
    //MARK: Intialization
    init(viewModel: CultivatorsDetailedVM!, TopSellingProductsProperties: TopSellingProductsProperties!) {
        self.viewModel = viewModel
        self.TopSellingProductsProperties = TopSellingProductsProperties
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
