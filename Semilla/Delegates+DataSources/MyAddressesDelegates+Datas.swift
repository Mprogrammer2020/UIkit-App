//
//  MyAddressesDelegates+Datas.swift
//  Semilla
//
//  Created by netset on 13/12/23.
//

import UIKit

//MARK: TableView Delegates Method
class MyAddressesDelegate: NSObject, UITableViewDelegate {
    
    //MARK: Variable Declaration
    private var viewModel:MyAddressesVM!
    private var myAddressesProperties: MyAddressesProperties!
    var didSelectCallback:((Int)->())?
    
    //MARK: Intialization
    init(viewModel: MyAddressesVM!, myAddressesProperties: MyAddressesProperties!) {
        self.viewModel = viewModel
        self.myAddressesProperties = myAddressesProperties
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.estimatedRowHeight = 80
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = viewModel.arrAddressList[indexPath.row]
        viewModel.selectedAddressId = (data.id ?? 0)
        CommonApis.shared.selectedPrimaryAddressApiMethod(viewModel.selectedAddressId) {
            primaryAddressSaved = data
            self.myAddressesProperties.tblVwAddressesList.reloadData()
            self.didSelectCallback?(indexPath.row)
        }
    }
    
}

class MyAddressesDatasources: NSObject,UITableViewDataSource {
    
    //MARK: Variable Declaration
    private var viewModel:MyAddressesVM!
    private var myAddressesProperties: MyAddressesProperties!
    var callBackToNavigateEditAddress:((Int)->())?
    
    //MARK: Intialization
    init(viewModel: MyAddressesVM!, myAddressesProperties: MyAddressesProperties!) {
        self.viewModel = viewModel
        self.myAddressesProperties = myAddressesProperties
    }
    
    //MARK: TableView Datasource Method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if viewModel.arrAddressList.count == 0 {
            myAddressesProperties.vwNoAddressFound.isHidden = false
        } else {
            myAddressesProperties.vwNoAddressFound.isHidden = true
            return viewModel.arrAddressList.count
        }
        
        return viewModel.arrAddressList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = viewModel.arrAddressList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCells.myAddressesListTVC, for: indexPath) as! AddresseslistTVC
        cell.lblAddressType.text = data.type
        if (data.city ?? "") != "" {
            cell.lblFullAddress.text = "\(data.apartmentNumber ?? ""), \(data.address ?? ""), \(data.city ?? ""), \(data.country ?? "")"
        } else {
            cell.lblFullAddress.text = data.address ?? ""
        }
        cell.lblUserAddressName.text = "\(data.firstName ?? "") \(data.lastName ?? "")"
        cell.btnEditAddress.tag = indexPath.row
        cell.btnDeleteAddress.tag = indexPath.row
        cell.btnEditAddress.addTarget(self, action: #selector(btnEditAddress(_:)), for: .touchUpInside)
        cell.btnDeleteAddress.addTarget(self, action: #selector(btnDeleteAddress(_:)), for: .touchUpInside)
        if (data.id ?? 0 ) ==  viewModel.selectedAddressId {
            cell.btnDeleteAddress.isHidden = true
            cell.btnEditAddress.isHidden = false
            cell.btnSelectAddress.setImage(UIImage(named: "ic_radio"), for: .normal)
        } else {
            cell.btnSelectAddress.setImage(UIImage(named: "ic_blank_radio"), for: .normal)
            cell.btnDeleteAddress.isHidden = false
            if viewModel.isComingFrom == "Shopping Cart" {
                cell.btnEditAddress.isHidden = true
                cell.btnDeleteAddress.isHidden = true
            } else {
                cell.btnEditAddress.isHidden = false
                cell.btnDeleteAddress.isHidden = false
            }
        }
        return cell
    }
    
    @objc func btnEditAddress(_ sender: UIButton) {
        self.callBackToNavigateEditAddress?(sender.tag)
    }
    
    @objc func btnDeleteAddress(_ sender: UIButton) {
        let selectedIndex = sender.tag
        let data = viewModel.arrAddressList[selectedIndex]
        Alerts.shared.alertMessageWithActionOkAndCancelYesNo(title: AlertMessages.appName, message: AlertMessages.areYouSureYouWantToDeleteAddress) {
            self.viewModel.deleteAddressDataApiMethod(data.id ?? 0) { [self] in
                viewModel.arrAddressList.remove(at: selectedIndex)
                myAddressesProperties.tblVwAddressesList.reloadData()
            }
        }
    }
    
}
