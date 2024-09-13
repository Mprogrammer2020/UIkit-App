//
//  VirtualCreditsVC.swift
//  Semilla
//
//  Created by Netset on 23/04/24.
//

import UIKit

class VirtualCreditsVC: UIViewController {

    //MARK: - IBOutlet's
    @IBOutlet var vwProperties: VirtualCreditsProperties!
    
    //MARK: - Variable Declaration
    var objVirtualCreditsVM = VirtualCreditsVM()
    private var vcDelegates: VirtualCreditsDelegates!
    private var vcDatasources: VirtualCreditsDataSources!
    private var vcScrollDelegate:VirtualCreditsScrolling!
    
    //MARK: - Viewlife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        delegatePushNotification = self
    }
    
    //MARK: - Delegates + Datasources
    func setupUI() {
        self.vwProperties.objDelegatesVirtualCredits = self
        vcDatasources = VirtualCreditsDataSources(viewModel: objVirtualCreditsVM, properties: vwProperties)
        vcDelegates = VirtualCreditsDelegates(viewModel: objVirtualCreditsVM, properties: vwProperties)
        vcScrollDelegate = VirtualCreditsScrolling(viewModel: objVirtualCreditsVM, properties: vwProperties)
        
        objVirtualCreditsVM.refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        vwProperties.vwScroll.refreshControl = objVirtualCreditsVM.refreshControl
        
        vwProperties.vwScroll.delegate = vcScrollDelegate
        objVirtualCreditsVM.creditsHistoryApiMethod(true) { [self] in
            vwProperties.showData(objVirtualCreditsVM.objVirtualCreditsData)
            vwProperties.tblVwCreditHistory.delegate = vcDelegates
            vwProperties.tblVwCreditHistory.dataSource = vcDatasources
            vwProperties.tblVwCreditHistory.reloadData()
        }
    }
    
    @objc func refreshData() {
        objVirtualCreditsVM.pageNumber = 0
        objVirtualCreditsVM.creditsHistoryApiMethod(false) {
            self.objVirtualCreditsVM.refreshControl.endRefreshing()
            self.vwProperties.tblVwCreditHistory.reloadData()
        }
    }
    
}
