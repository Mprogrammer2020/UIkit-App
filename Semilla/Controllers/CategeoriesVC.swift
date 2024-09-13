//
//  CategeoriesVC.swift
//  Semilla
//
//  Created by Netset on 05/12/23.
//

import UIKit

class CategeoriesVC: UIViewController {
    
    //MARK: IBOutlet's
    @IBOutlet var vwProperties: CategeoriesProperties!
    
    //MARK: Variable Declaration
    var objcategeoriesVM = CategeoriesVM()
    private var colVwDataSource: CategeoriesColVwDatasouces!
    private var colVwDelegates: CategeoriesColVwDelegate!
    
    //MARK: Viewlife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.intializeViewDataSource()
    }
    
    //MARK: Custom Function
    private func intializeViewDataSource() {
        self.vwProperties.objCategeoriesDelegate = self
        vwProperties.activityIndicator.isHidden = true
        
        vwProperties.colVwCategeories.register(UINib.init(nibName: "CategeoryCVC", bundle: nil), forCellWithReuseIdentifier: "CategeoryCVC")
        vwProperties.colVwCategeorieItems.register(UINib.init(nibName: "RecentlyListedCVC", bundle: nil), forCellWithReuseIdentifier: "RecentlyListedCVC")
        
        colVwDataSource = CategeoriesColVwDatasouces(viewModel: objcategeoriesVM, properties: vwProperties)
        colVwDelegates = CategeoriesColVwDelegate(viewModel: objcategeoriesVM, properties: vwProperties)
        
        objcategeoriesVM.refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        vwProperties.colVwCategeorieItems.refreshControl = objcategeoriesVM.refreshControl
        
        self.objcategeoriesVM.pageNumber = 0
        
        objcategeoriesVM.categeoriesApiMethod { [self] in
            vwProperties.colVwCategeories.delegate = colVwDelegates
            vwProperties.colVwCategeories.dataSource = colVwDataSource
            vwProperties.colVwCategeories.reloadData()
        }
        
        self.objcategeoriesVM.recentlyListedApiMethod(self.objcategeoriesVM.selectedCategoryId, isLoader: true) { [self] in
            vwProperties.colVwCategeorieItems.delegate = colVwDelegates
            vwProperties.colVwCategeorieItems.dataSource = colVwDataSource
            vwProperties.colVwCategeorieItems.reloadData()
        }

        self.colVwDelegates.callBackToNavigateItemDetailed = { index in
            let vc = getStoryboard(.home).instantiateViewController(withIdentifier: ViewControllers.itemDetailedVC) as! ItemDetailedVC
            vc.objViewModel.detailId = self.objcategeoriesVM.arrRecentList[index].id ?? 0
            vc.objViewModel.productId = self.objcategeoriesVM.arrRecentList[index].productCultivatorId ?? 0
            vc.objViewModel.isSearchHistory = self.vwProperties.txtFldSearch.isBlank ? false : true
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        colVwDelegates.clearFieldText = {
            self.handleSearchData(self.vwProperties.txtFldSearch.text ?? "")
        }
        
        self.colVwDataSource.callBackToNavigatePopup = { index in
            let data = self.objcategeoriesVM.arrRecentList[index]
            let vc = getStoryboard(.checkout).instantiateViewController(withIdentifier: ViewControllers.customizeQtyVC) as! CustomizeQuantityVC
            vc.objCustomizeQuantityVM.stockId = data.productCultivatorId ?? 0
            vc.callBackToShowItemCount = {
                CommonApis.shared.shoppingCartCountApiMethod { (objCounts) in
                    if objCounts.cartCount == 0 {
                        self.vwProperties.vwCartCount.isHidden = true
                    } else {
                        self.vwProperties.lblCartCount.text = "\(objCounts.cartCount)"
                        self.vwProperties.vwCartCount.isHidden = false
                    }
                }
            }
            self.present(vc, animated: true)
        }
    }
    
    //MARK: - Refresh Data Action's
    @objc func refreshData() {
        objcategeoriesVM.pageNumber = 0
        objcategeoriesVM.recentlyListedApiMethod(objcategeoriesVM.selectedCategoryId, isLoader: false) { [self] in
            self.objcategeoriesVM.refreshControl.endRefreshing()
            self.vwProperties.colVwCategeorieItems.reloadData()
        }
    }
    
    //MARK: - Viewlife Cycle
    override func viewWillAppear(_ animated: Bool) {
        if isGuestUser == true {
            vwProperties.imgVwNotificationIcon.image = UIImage(named: "ic-Notifications1")
        } else {
            CommonApis.shared.shoppingCartCountApiMethod { (objCounts) in
                if objCounts.cartCount == 0 {
                    self.vwProperties.vwCartCount.isHidden = true
                } else {
                    self.vwProperties.lblCartCount.text = "\(objCounts.cartCount)"
                    self.vwProperties.vwCartCount.isHidden = false
                }
            }
            checkDataWithLocalDataBase()
            if isShowNotificationCount == true {
                vwProperties.imgVwNotificationIcon.image = UIImage(named: "ic-Notification")
            } else {
                vwProperties.imgVwNotificationIcon.image = UIImage(named: "ic-Notifications1")
            }
        }
    }
    
    // MARK: - Check data in local database
    func checkDataWithLocalDataBase() {
        if objcategeoriesVM.arrRecentList.count > 0 {
            for i in 0..<arrCartAllData.count {
                let data = arrCartAllData[i]
                if let index = objcategeoriesVM.arrRecentList.firstIndex(where: { $0.productCultivatorId ?? 0 == data.cartId }) {
                    objcategeoriesVM.arrRecentList[index].inCart = data.cartCount
                }
            }
        }
        vwProperties.colVwCategeorieItems.reloadData()
    }
    
    
}
