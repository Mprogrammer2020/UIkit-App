//
//  OurProductsVC.swift
//  Semilla
//
//  Created by Netset on 26/12/23.
//

import UIKit

class OurProductsVC: UIViewController {
    
    //MARK: IBOutlet's
    @IBOutlet var vwProperties: OurProductsProperties!
    
    //MARK: VariableDeclarations
    var objOurProductsVM = CultivatorsDetailedVM()
    var ourProductsColVwDelegates: OurProductsDelegates!
    var ourProductsColVwDatasources: OurProductsDataSources!
    
    
    //MARK: Viewlife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.intializeViewDataSource()
        vwProperties.activityIndicator.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkDataWithLocalDataBase()
    }
    
    
    //MARK: Custom Function
    private func intializeViewDataSource() {
        self.vwProperties.objOurProductsDelegate = self
        vwProperties.colVwAllOurProducts.register(UINib.init(nibName: "RecentlyListedCVC", bundle: nil), forCellWithReuseIdentifier: "RecentlyListedCVC")
        
        ourProductsColVwDelegates = OurProductsDelegates(viewModel: objOurProductsVM, ourProductsProperties: vwProperties)
        ourProductsColVwDatasources = OurProductsDataSources(viewModel: objOurProductsVM, ourProductsProperties: vwProperties)
        
        objOurProductsVM.refreshControl.addTarget(self, action: #selector(refreshData), for: UIControl.Event.valueChanged)
        vwProperties.colVwAllOurProducts.refreshControl = objOurProductsVM.refreshControl
        
        vwProperties.colVwAllOurProducts.delegate = ourProductsColVwDelegates
        vwProperties.colVwAllOurProducts.dataSource = ourProductsColVwDatasources
        
        objOurProductsVM.pageNumber = 0
        objOurProductsVM.cultivatorProductsApiMethod(objOurProductsVM.cultivatorId, isLoader: true) { [self] in
            vwProperties.colVwAllOurProducts.reloadData()
        }
        
        // Add Button Click
        ourProductsColVwDatasources.callBackToAddedInCart = { indexPath in
            let data = self.objOurProductsVM.objCultivatorProducts[indexPath]
            let vc = getStoryboard(.checkout).instantiateViewController(withIdentifier: ViewControllers.customizeQtyVC) as! CustomizeQuantityVC
            vc.objCustomizeQuantityVM.stockId = data.id ?? 0
            self.present(vc, animated: true)
        }
        
        //on did select click
        ourProductsColVwDelegates.callBackToItemDetailed = { index in
            let data = self.objOurProductsVM.objCultivatorProducts[index]
            let vc = getStoryboard(.home).instantiateViewController(withIdentifier: ViewControllers.itemDetailedVC) as! ItemDetailedVC
            vc.objViewModel.detailId = data.id ?? 0
            vc.objViewModel.productId = self.objOurProductsVM.objCultivatorProducts[index].productId ?? 0
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func refreshData() {
        objOurProductsVM.pageNumber = 0
        objOurProductsVM.cultivatorProductsApiMethod(objOurProductsVM.cultivatorId, isLoader: false) {
            self.vwProperties.colVwAllOurProducts.reloadData()
            self.objOurProductsVM.refreshControl.endRefreshing()
        }
    }
    
    //MARK: - Check Data with local Database
    func checkDataWithLocalDataBase() {
        if objOurProductsVM.objCultivatorProducts.count > 0 {
            for i in 0..<arrCartAllData.count {
                let data = arrCartAllData[i]
                if let index = objOurProductsVM.objCultivatorProducts.firstIndex(where: { $0.productCultivatorId ?? 0 == data.cartId }) {
                    objOurProductsVM.objCultivatorProducts[index].inCart = data.cartCount
                }
            }
        }
        vwProperties.colVwAllOurProducts.reloadData()
    }
}
