//
//  AddressPopupDelegate+Datas.swift
//  Semilla
//
//  Created by Netset on 22/03/24.
//

import UIKit

//MARK: TableView Delegates Method
class AddressPopupDelegate: NSObject, UITableViewDelegate {
    
    //MARK: Variable Declaration
    private var viewModel:AddressPopupVM!
    private var myAddressesProperties: AddressPopupProperties!
    var didSelectCallback:((Int)->())?
    
    //MARK: Intialization
    init(viewModel: AddressPopupVM!, myAddressesProperties: AddressPopupProperties!) {
        self.viewModel = viewModel
        self.myAddressesProperties = myAddressesProperties
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.estimatedRowHeight = 80
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectedIndex = indexPath.row
        tableView.reloadData()
        self.didSelectCallback?(indexPath.row)
    }
    
}

class AddressPopupDataSources: NSObject,UITableViewDataSource {
    
    //MARK: Variable Declaration
    private var viewModel:AddressPopupVM!
    private var myAddressesProperties: AddressPopupProperties!
    var callBackToNavigateEditAddress:((Int)->())?

    //MARK: Intialization
    init(viewModel: AddressPopupVM!, myAddressesProperties: AddressPopupProperties!) {
        self.viewModel = viewModel
        self.myAddressesProperties = myAddressesProperties
    }
    
    //MARK: TableView Datasource Method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.arrAddressList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = viewModel.arrAddressList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCells.addressPopupTVC , for: indexPath) as! AddressPopupTVC
        cell.lblAddressType.text = data.type
        if (data.city ?? "") != "" {
            cell.lblAddress.text = "\(data.apartmentNumber ?? ""), \(data.address ?? ""), \(data.city ?? ""), \(data.country ?? "")"
        } else {
            cell.lblAddress.text = data.address ?? ""
        }
        cell.lblAddressName.text = "\(data.firstName ?? "") \(data.lastName ?? "")"
        
        if viewModel.selectedIndex == indexPath.row {
            cell.btnSelectAddress.setImage(UIImage(named: "ic_radio"), for: .normal)
        } else {
            cell.btnSelectAddress.setImage(UIImage(named: "ic_blank_radio"), for: .normal)          
        }
        return cell
    }
    
}
