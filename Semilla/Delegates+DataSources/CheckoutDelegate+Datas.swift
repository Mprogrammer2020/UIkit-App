//
//  CheckoutDelegate+Datas.swift
//  Semilla
//
//  Created by Netset on 15/12/23.
//

import UIKit

class CheckoutDataSources: NSObject,UITableViewDataSource {
 
    //MARK: Variable Declaration
    var viewModelCheckOut: CheckoutVM!
    var checkoutProperties: CheckoutProperties!
    
    //MARK: Intialization
    init(viewModel: CheckoutVM!, checkoutProperties: CheckoutProperties!) {
        self.viewModelCheckOut = viewModel
        self.checkoutProperties = checkoutProperties
    }
    
    //MARK: TableView Datasource Method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModelCheckOut.arrItemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCells.checkoutOrderListTVC, for: indexPath) as! CheckoutOrderListTVC
        let data = viewModelCheckOut.arrItemList[indexPath.row]
        cell.imgVwItemImg.setImageOnImageViewServer(data.productImagePath ?? "", placeholder: UIImage(named: "ic_PlaceHolder2")!)
        cell.lblItemName.text = data.productName ?? ""
        cell.lblItemPrice.text = "$\(CommonMethod.shared.convertToColombianPeso(amount: (data.productTotal ?? 0)) ?? "")" //"$\((data.productTotal ?? 0).addZero)"
        cell.lblItemPerGram.text = "$\(CommonMethod.shared.convertToColombianPeso(amount: (data.pricePerUnit ?? 0)) ?? "")" //"$\((data.pricePerUnit ?? 0).addZero)/ \(data.unit ?? "")"
        cell.lblQty.text = "\((data.productTotalQuantity ?? 0))X\((data.packaging ?? 0).removeZero) \(data.unit ?? "")"
        UIView.animate(withDuration: 0, animations: {
            tableView.layoutIfNeeded()
        }) { complete in
            self.checkoutProperties.cnstHeightTblVw.constant = self.checkoutProperties.tblVwItemsList.contentSize.height
        }
        return cell
    }
    
}

//MARK: TableView Delegates Method
class CheckoutDelegate: NSObject, UITableViewDelegate{
 
    //MARK: Variable Declaration
    var viewModel: CheckoutVM!
    var checkoutProperties: CheckoutProperties!
    
    //MARK: Intialization
    init(viewModel: CheckoutVM!, checkoutProperties: CheckoutProperties!) {
        self.viewModel = viewModel
        self.checkoutProperties = checkoutProperties
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.estimatedRowHeight = 100
        return UITableView.automaticDimension
    }
    
}
 
