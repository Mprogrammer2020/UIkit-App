//
//  PaymentMethodDelegate+Datas.swift
//  Semilla
//
//  Created by Netset on 15/12/23.
//

import UIKit

class PaymentMethodDataSources: NSObject, UITableViewDataSource {

    //MARK: Variable Declaration
    var viewModel: PaymentMethodVM!
    var paymentMethodProperties: PaymentMethodProperties!
    
    //MARK: Intialization
    init(viewModel: PaymentMethodVM!, paymentMethodProperties: PaymentMethodProperties!) {
        self.viewModel = viewModel
        self.paymentMethodProperties = paymentMethodProperties
    }
    
    //MARK: TableView Datasource Method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cardDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCells.paymentMethodCardListTVC, for: indexPath) as!
        PaymentMethodCardListTVC
        let data = viewModel.cardDetails[indexPath.row]
        cell.imgVwCardType.image = UIImage(named: data.cardImage ?? "")
        cell.lblCardName.text = data.cardType
        cell.lblCardLast4Digit.text = data.lastFourDigit
        cell.lblCardCVV.text = data.cvv
        return cell
    }
    
}

//MARK: TableView Delegates Method
class PaymentMethodDelegate: NSObject, UITableViewDelegate {
    
    //MARK: Variable Declaration
    var viewModel: PaymentMethodVM!
    var paymentMethodProperties: PaymentMethodProperties!
    
    //MARK: Intialization
    init(viewModel: PaymentMethodVM!, paymentMethodProperties: PaymentMethodProperties!) {
        self.viewModel = viewModel
        self.paymentMethodProperties = paymentMethodProperties
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
