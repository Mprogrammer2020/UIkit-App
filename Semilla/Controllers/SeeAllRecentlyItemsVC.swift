//
//  SeeAllRecentlyItemsVC.swift
//  Semilla
//
//  Created by Inder Sandhu on 16/12/23.
//

import UIKit

class SeeAllRecentlyItemsVC: UIViewController {
    
    //MARK: IBOutlet's
    @IBOutlet var vwProperties: SeeAllRecentlyItemsProperties!
    var objSeeAllRecentlyVM = SeeAllRecentlyItemsVM()
    private var colVwDataSource: SeeAllRecentlyColVwDatasouces!
    private var colVwDelegates: SeeAllRecentlyColVwDelegate!
    
    //MARK: Viewlife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        intializeViewDataSource()
        vwProperties.activityIndicator.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkDataWithLocalDataBase()
    }
    
    //MARK: Variable Declaration
    private func intializeViewDataSource() {
        self.vwProperties.objSeeAllDelegates = self
        vwProperties.colVwCategeories.register(UINib.init(nibName: "CategeoryCVC", bundle: nil), forCellWithReuseIdentifier: "CategeoryCVC")
        vwProperties.colVwRecentlyItems.register(UINib.init(nibName: "RecentlyListedCVC", bundle: nil), forCellWithReuseIdentifier: "RecentlyListedCVC")
        colVwDataSource = SeeAllRecentlyColVwDatasouces(viewModel: objSeeAllRecentlyVM,seeAllRecentlyColVwProperties: vwProperties)
        colVwDelegates = SeeAllRecentlyColVwDelegate(viewModel: objSeeAllRecentlyVM, properties: vwProperties)
        objSeeAllRecentlyVM.refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        vwProperties.colVwRecentlyItems.refreshControl = objSeeAllRecentlyVM.refreshControl
        
        objSeeAllRecentlyVM.recentlyListedApiMethod(objSeeAllRecentlyVM.selectCategoryId, isLoader: true) { [self] in
            vwProperties.colVwRecentlyItems.delegate = colVwDelegates
            vwProperties.colVwRecentlyItems.dataSource = colVwDataSource
            vwProperties.colVwRecentlyItems.reloadData()
        }
        
        vwProperties.colVwCategeories.delegate = colVwDelegates
        vwProperties.colVwCategeories.dataSource = colVwDataSource
        vwProperties.colVwCategeories.reloadData()
        
        // On Item Click
        colVwDelegates.callBackToNavigateItemDetails = { indexPath in
            let data = self.objSeeAllRecentlyVM.arrRecentList[indexPath]
            let vc = getStoryboard(.home).instantiateViewController(withIdentifier: ViewControllers.itemDetailedVC) as! ItemDetailedVC
            vc.objViewModel.detailId = data.id ?? 0
            vc.objViewModel.productId = self.objSeeAllRecentlyVM.arrRecentList[indexPath].productCultivatorId ?? 0
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        // On Button Click
        colVwDataSource.callBackToNavigatePopup = { (indexPath) in
            let data = self.objSeeAllRecentlyVM.arrRecentList[indexPath]
            let vc = getStoryboard(.checkout).instantiateViewController(withIdentifier: ViewControllers.customizeQtyVC) as! CustomizeQuantityVC
            vc.objCustomizeQuantityVM.stockId = data.productCultivatorId ?? 0
            self.present(vc, animated: true)
        }
        
    }
    
    //MARK: -  Refresh Data Action's
    @objc func refreshData() {
        objSeeAllRecentlyVM.pageNumber = 0
        objSeeAllRecentlyVM.recentlyListedApiMethod(objSeeAllRecentlyVM.selectCategoryId, isLoader: false) {
            self.objSeeAllRecentlyVM.refreshControl.endRefreshing()
            self.vwProperties.colVwRecentlyItems.reloadData()
        }
    }
    
    //MARK: - Check Data With Local Database
    func checkDataWithLocalDataBase() {
        if objSeeAllRecentlyVM.arrRecentList.count > 0 {
            for i in 0..<arrCartAllData.count {
                let data = arrCartAllData[i]
                if let index = objSeeAllRecentlyVM.arrRecentList.firstIndex(where: { $0.productCultivatorId ?? 0 == data.cartId }) {
                    objSeeAllRecentlyVM.arrRecentList[index].inCart = data.cartCount
                }
            }
        }
        vwProperties.colVwRecentlyItems.reloadData()
    }
    
}
