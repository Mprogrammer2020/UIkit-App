//
//  OrderHistoryVC.swift
//  Semilla
//
//  Created by netset on 07/12/23.
//

import UIKit

class OrderHistoryVC: UIViewController {
    
    //MARK: IBOutlet's
    @IBOutlet var vwProperties: OrderHistoryProperties!
    
    //MARK: Variable Declaration
    var ObjviewModel = OrderHistoryVM()
    var tblVwOrderHistoryDelegates: OrderHistoryDelegates!
    var tblVwOrderHistoryDatasources: OrderHistoryDatasource!
    
    //MARK: Viewlife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        intializeViewDataSource()
        vwProperties.activityIndicator.isHidden = true
    }
    
    //MARK: Custom Function
    private func intializeViewDataSource() {
        self.vwProperties.objOrderHistoryDelegate = self
        tblVwOrderHistoryDatasources = OrderHistoryDatasource(viewModel: ObjviewModel, orderHistoryProperties: vwProperties)
        tblVwOrderHistoryDelegates = OrderHistoryDelegates(viewModel: ObjviewModel, orderHistoryProperties: vwProperties)
        ObjviewModel.refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: UIControl.Event.valueChanged)
        vwProperties.tblVwOrderHistoryList.refreshControl = ObjviewModel.refreshControl
        ObjviewModel.pageNumber = 0
        ObjviewModel.orderHistoryApiMethod(true) { [self] in
            vwProperties.tblVwOrderHistoryList.delegate = tblVwOrderHistoryDelegates
            vwProperties.tblVwOrderHistoryList.dataSource = tblVwOrderHistoryDatasources
            vwProperties.tblVwOrderHistoryList.reloadData()
        }
        self.tblVwOrderHistoryDelegates.callBackToNavigateOrderHistoryDetails = { (Index,status) in
            let vc = getStoryboard(Storyboards.checkout).instantiateViewController(withIdentifier: ViewControllers.checkoutVC) as! CheckoutVC
            vc.objViewModel.orderId = self.ObjviewModel.arrOrderHistory[Index].orderId ?? 0
            vc.objViewModel.callBackOrderCancel = {
                self.ObjviewModel.pageNumber = 0
                self.ObjviewModel.orderHistoryApiMethod(false) { [self] in
                    vwProperties.tblVwOrderHistoryList.reloadData()
                }
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    //MARK: - Refresh Data Action
    @objc func refreshData(_ sender: Any) {
        ObjviewModel.pageNumber = 0
        ObjviewModel.orderHistoryApiMethod(false) {
            self.vwProperties.tblVwOrderHistoryList.reloadData()
            self.ObjviewModel.refreshControl.endRefreshing()
        }
    }
    
}
