//
//  OrderHistoryDetails.swift
//  Semilla
//
//  Created by netset on 07/12/23.
//

import UIKit

class OrderHistoryDetailedVC: UIViewController {
    
    //MARK: IBOutlet's
    @IBOutlet var vwProperties: OrderHistoryDetailedProperties!
    
    //MARK: Variable Declaration
    var objViewModel = OrderHistoryVM()
    var tblVwOrderHistoryDetailedDataSources: OrderHistoryDetailedDataSources!
    var tblVwOrderHistoryDetailedDelegates: OrderHistoryDetailedDelegates!
    
    //MARK: Viewlife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.intializeViewDataSource()
    }
    
    //MARK: Custom Functions
    private func intializeViewDataSource() {
        self.vwProperties.objOrderHistoryDetailedDelegates = self
        tblVwOrderHistoryDetailedDataSources = OrderHistoryDetailedDataSources(viewModelOrderHistoryDetailed: objViewModel, orderHistoryDetailedProperties: vwProperties)
        tblVwOrderHistoryDetailedDelegates = OrderHistoryDetailedDelegates(viewModelOrderHistoryDetailed: objViewModel, orderHistoryDetailedProperties: vwProperties)
        
        vwProperties.tblVwOrderStatus.delegate = tblVwOrderHistoryDetailedDelegates
        vwProperties.tblVwOrderStatus.dataSource = tblVwOrderHistoryDetailedDataSources
        vwProperties.tblVwOrderStatus.reloadData()
        
        
    }
    
}
