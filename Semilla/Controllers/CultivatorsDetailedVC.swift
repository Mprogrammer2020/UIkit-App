//
//  CultivatorsDetailedVC.swift
//  Semilla
//
//  Created by netset on 13/12/23.
//

import UIKit

class CultivatorsDetailedVC: UIViewController {
    
    
    //MARK: IBOutlet's
    @IBOutlet var vwProperties: CultivatorsDetailedProperties!
    
    //MARK: Variable Declarations
    var objCultivatorsDetailedViewModel = CultivatorsDetailedVM()
    let refreshControl = UIRefreshControl()
    private var cultivatorsDetailedColVwDelegates: CultivatorColVwDetailedDelegates!
    private var cultivatorsDetailedColVwDatasources: CultivatorColVwDetailedDatasources!
    
    //MARK: Viewlife cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        intializeViewDataSource()
        if objCultivatorsDetailedViewModel.isComingFrom == "ItemDetailed" {
            vwProperties.showCultivatorDetailedFromItemDetailed(firstName: objCultivatorsDetailedViewModel.firstName, lastName: objCultivatorsDetailedViewModel.lastName, image: objCultivatorsDetailedViewModel.Image, rating: objCultivatorsDetailedViewModel.rating)
        } else {
            vwProperties.showCultivatorDetails(objCultivatorsDetailedViewModel.objCultivatorData)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkDataWithLocalDataBase()
    }
    
    //MARK: Custom Function
    private func intializeViewDataSource() {
        vwProperties.activityIndicator.isHidden = true
        self.vwProperties.objCultivatorsDetailedDelegate = self
        vwProperties.colVwOurProducts.register(UINib.init(nibName: "RecentlyListedCVC", bundle: nil), forCellWithReuseIdentifier: "RecentlyListedCVC")
        
        cultivatorsDetailedColVwDelegates = CultivatorColVwDetailedDelegates(viewModel: objCultivatorsDetailedViewModel, CultivatorsDetailedProperties: vwProperties)
        cultivatorsDetailedColVwDatasources = CultivatorColVwDetailedDatasources(viewModel: objCultivatorsDetailedViewModel, CultivatorsDetailedProperties: vwProperties)
        
        objCultivatorsDetailedViewModel.refreshControl.addTarget(self, action: #selector(refreshData), for: UIControl.Event.valueChanged)
        vwProperties.colVwOurProducts.refreshControl = objCultivatorsDetailedViewModel.refreshControl

        objCultivatorsDetailedViewModel.cultivatorProductsApiMethod(objCultivatorsDetailedViewModel.cultivatorId, isLoader: true) { [self] in
            vwProperties.colVwOurProducts.delegate = cultivatorsDetailedColVwDelegates
            vwProperties.colVwOurProducts.dataSource = cultivatorsDetailedColVwDatasources
            vwProperties.colVwOurProducts.reloadData()
        }
        
        //on btn click
        cultivatorsDetailedColVwDatasources.callBackToNavigatePopup = { indexPath in
            let data = self.objCultivatorsDetailedViewModel.objCultivatorProducts[indexPath]
            let vc = getStoryboard(.checkout).instantiateViewController(withIdentifier: ViewControllers.customizeQtyVC) as! CustomizeQuantityVC
            vc.objCustomizeQuantityVM.stockId = data.id ?? 0
            self.present(vc, animated: true)
        }
        
        //on did select click
        cultivatorsDetailedColVwDelegates.callBackToItemDetail = { index in
            let data = self.objCultivatorsDetailedViewModel.objCultivatorProducts[index]
            let vc = getStoryboard(.home).instantiateViewController(withIdentifier: ViewControllers.itemDetailedVC) as! ItemDetailedVC
            vc.objViewModel.detailId = data.id ?? 0
            vc.objViewModel.productId = self.objCultivatorsDetailedViewModel.objCultivatorProducts[index].productCultivatorId ?? 0
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // MARK: - Refresh Data Action's
    @objc func refreshData() {
        objCultivatorsDetailedViewModel.pageNumber = 0
        objCultivatorsDetailedViewModel.cultivatorProductsApiMethod(objCultivatorsDetailedViewModel.cultivatorId, isLoader: false) {
            self.vwProperties.colVwOurProducts.reloadData()
            self.objCultivatorsDetailedViewModel.refreshControl.endRefreshing()
        }
    }
    
    // MARK: - Check Data With Local Database
    func checkDataWithLocalDataBase() {
        if objCultivatorsDetailedViewModel.objCultivatorProducts.count > 0 {
            for i in 0..<arrCartAllData.count {
                let data = arrCartAllData[i]
                if let index = objCultivatorsDetailedViewModel.objCultivatorProducts.firstIndex(where: { $0.productCultivatorId ?? 0 == data.cartId }) {
                    objCultivatorsDetailedViewModel.objCultivatorProducts[index].inCart = data.cartCount
                }
            }
        }
        vwProperties.colVwOurProducts.reloadData()
    }
    
}
