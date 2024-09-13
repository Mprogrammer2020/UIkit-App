//
//  SearchHistoryVC.swift
//  Semilla
//
//  Created by Netset on 21/12/23.
//

import UIKit

class SearchHistoryVC: UIViewController {
    
    //MARK: IBOutlet's
    @IBOutlet var vwProperties: SearchHistoryProperties!
    
    //MARK: Variable Declaration
    var objSearchHistoryVM = SearchHistoryVM()
    var searchHistoryColVwDelegates: SearchHistoryDelegates!
    var searchHistoryColVwDatasource: SearchHistoryDataSources!
    
    //MARK: Viewlife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.intializeViewDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkDataWithLocalDataBase()
    }
    
    //MARK: Custom Function
    private func intializeViewDataSource() {
        self.vwProperties.objSearchHistoryDelegate = self
        self.vwProperties.activityIndicator.isHidden = true
        vwProperties.colVwSearchItems.register(UINib.init(nibName: "RecentlyListedCVC", bundle: nil), forCellWithReuseIdentifier: "RecentlyListedCVC")
        searchHistoryColVwDatasource = SearchHistoryDataSources(viewModel: objSearchHistoryVM, properties: vwProperties)
        searchHistoryColVwDelegates = SearchHistoryDelegates(viewModel: objSearchHistoryVM, properties: vwProperties)
        
        objSearchHistoryVM.searchListedApiMethod(objSearchHistoryVM.selectCategoryId, isLoader: true) { [self] in
            vwProperties.colVwSearchItems.delegate = searchHistoryColVwDelegates
            vwProperties.colVwSearchItems.dataSource = searchHistoryColVwDatasource
            vwProperties.colVwSearchItems.reloadData()
        }
        
        //On Item Click
        searchHistoryColVwDelegates.callBackToNavigateItemDetails = { index in
            let data = self.objSearchHistoryVM.arrRecentList[index]
            let vc = getStoryboard(.home).instantiateViewController(withIdentifier: ViewControllers.itemDetailedVC) as! ItemDetailedVC
            vc.objViewModel.detailId = data.id ?? 0
            vc.objViewModel.productId = self.objSearchHistoryVM.arrRecentList[index].productCultivatorId ?? 0
            vc.objViewModel.isSearchHistory = self.vwProperties.txtFldSearch.isBlank ? false : true
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        // On Button Click
        searchHistoryColVwDatasource.callBackToNavigateItemDetails = { (indexPath) in
            let data = self.objSearchHistoryVM.arrRecentList[indexPath]
            let vc = getStoryboard(.checkout).instantiateViewController(withIdentifier: ViewControllers.customizeQtyVC) as! CustomizeQuantityVC
            vc.objCustomizeQuantityVM.stockId = data.id ?? 0
            self.present(vc, animated: true)
        }
        
        // Clear Text Fields
        searchHistoryColVwDelegates.clearFields = {
            self.handleSearchData(self.vwProperties.txtFldSearch.text ?? "")
        }
    }
    
    //MARK: -  Refresh Data Action's
    @objc func refreshData() {
        objSearchHistoryVM.pageNumber = 0
        objSearchHistoryVM.searchListedApiMethod(objSearchHistoryVM.selectCategoryId, isLoader: true) {
            self.objSearchHistoryVM.refreshControl.endRefreshing()
            self.vwProperties.colVwSearchItems.reloadData()
        }
    }
    
    //MARK: - Check Data with local Database
    func checkDataWithLocalDataBase() {
        if objSearchHistoryVM.arrRecentList.count > 0 {
            for i in 0..<arrCartAllData.count {
                let data = arrCartAllData[i]
                if let index = objSearchHistoryVM.arrRecentList.firstIndex(where: { $0.productCultivatorId ?? 0 == data.cartId }) {
                    objSearchHistoryVM.arrRecentList[index].inCart = data.cartCount
                }
            }
        }
        vwProperties.colVwSearchItems.reloadData()
    }
    
}
