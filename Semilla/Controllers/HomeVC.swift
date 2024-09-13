//
//  HomeVC.swift
//  Semilla
//
//  Created by Netset on 30/11/23.
//

import UIKit

class HomeVC: UIViewController {
    
    //MARK: IBOutlet's
    @IBOutlet var vwProperties: HomeProperties!
    
    //MARK: Variables Declare
    var objHomeVM = HomeVM()
    private var colVwDataSource: HomeColVwDatasouces!
    private var colVwDelegates: HomeColVwDelegate!
    
    //MARK: Viewlife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        CommonApis.shared.updateDeviceTokenApi()
        SocketIOManager.sharedInstance.connectToServer()
        self.intializeViewDataSource()
    }
    
    //MARK: - Custom Function
    private func intializeViewDataSource() {
        
        vwProperties.objHomeDelegates = self
        vwProperties.colVwCategeory.register(UINib.init(nibName: "CategeoryCVC", bundle: nil), forCellWithReuseIdentifier: "CategeoryCVC")
        vwProperties.colVwRecentlyListed.register(UINib.init(nibName: "RecentlyListedCVC", bundle: nil), forCellWithReuseIdentifier: "RecentlyListedCVC")
        vwProperties.colVwBestFarmers.register(UINib.init(nibName: "BestFarmersCVC", bundle: nil), forCellWithReuseIdentifier: "BestFarmersCVC")
        objHomeVM.refreshControl.addTarget(self, action: #selector(refreshData), for: UIControl.Event.valueChanged)
        vwProperties.scrollVwHome.refreshControl = objHomeVM.refreshControl
        colVwDataSource = HomeColVwDatasouces(viewModel: objHomeVM, properties: vwProperties)
        colVwDelegates = HomeColVwDelegate(viewModel: objHomeVM, properties: vwProperties)
        
        objHomeVM.categeoriesApiMethod(true) { [self] in
            vwProperties.colVwCategeory.delegate = colVwDelegates
            vwProperties.colVwCategeory.dataSource = colVwDataSource
            vwProperties.colVwCategeory.reloadData()
        }
        
        objHomeVM.trandingCultivatorApiMethod(true) { [self] in
            vwProperties.colVwBestFarmers.delegate = colVwDelegates
            vwProperties.colVwBestFarmers.dataSource = colVwDataSource
            vwProperties.colVwBestFarmers.reloadData()
        }
        //On Item Click
        colVwDelegates.callBackToNavigateItemDetails = { index in
            let data = self.objHomeVM.arrRecentList[index]
            let vc = getStoryboard(.home).instantiateViewController(withIdentifier: ViewControllers.itemDetailedVC) as! ItemDetailedVC
            vc.objViewModel.detailId = data.id ?? 0
            vc.objViewModel.productId = self.objHomeVM.arrRecentList[index].productCultivatorId ?? 0
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        // On Button Click
        colVwDataSource.callBackToNavigatePopup = { (indexPath) in
            let data = self.objHomeVM.arrRecentList[indexPath]
            let vc = getStoryboard(.checkout).instantiateViewController(withIdentifier: ViewControllers.customizeQtyVC) as! CustomizeQuantityVC
            vc.objCustomizeQuantityVM.stockId = data.id ?? 0
            vc.callBackToShowItemCount = {
                CommonApis.shared.shoppingCartCountApiMethod { (objCounts) in
                    if objCounts.cartCount == 0 {
                        self.vwProperties.vwShoppingCount.isHidden = true
                    } else {
                        self.vwProperties.lblCartCount.text = "\(objCounts.cartCount)"
                        self.vwProperties.vwShoppingCount.isHidden = false
                    }
                }
            }
            self.present(vc, animated: true)
        }
        
        //On Best Farmers
        colVwDelegates.callBackToNavigateBestFarmers = { indexPath in
            let data = self.objHomeVM.arrCultivator[indexPath]
            CommonApis.shared.cultivatorOfflineApiMethod(data.id ?? 0) {
                if isOnline != true {
                    Alerts.shared.showAlert(title: AlertMessages.appName, message: ValidationMessages.cultivatorStatus)
                } else {
                    let vc = getStoryboard(.home).instantiateViewController(withIdentifier: ViewControllers.cultivatorsDetailedVC) as! CultivatorsDetailedVC
                    vc.objCultivatorsDetailedViewModel.cultivatorId = data.id ?? 0
                    vc.objCultivatorsDetailedViewModel.objCultivatorData = self.objHomeVM.arrCultivator[indexPath]
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
        //MARK: - Refresh Data Action
    @objc func refreshData() {
        objHomeVM.pageNumber = 0
        objHomeVM.categeoriesApiMethod(false) {
            self.vwProperties.colVwCategeory.reloadData()
        }
        objHomeVM.recentlyListedApiMethod(objHomeVM.selectCategoryId, isLoader: false) {
            self.vwProperties.colVwRecentlyListed.reloadData()
        }
        objHomeVM.trandingCultivatorApiMethod(false) {
            self.objHomeVM.refreshControl.endRefreshing()
            self.vwProperties.colVwBestFarmers.reloadData()
        }
    }
    
    //MARK: Viewlife Cycle
    override func viewWillAppear(_ animated: Bool) {
        let locationManager = LocationManager.sharedLocationManager()
        locationManager.startStandardUpdates()
        if isGuestUser == true {
            vwProperties.imgVwNotificationIcon.image = UIImage(named: "ic-Notifications1")
        } else {
            CommonApis.shared.shoppingCartCountApiMethod { (objCounts) in
                if objCounts.cartCount == 0 {
                    self.vwProperties.vwShoppingCount.isHidden = true
                } else {
                    self.vwProperties.lblCartCount.text = "\(objCounts.cartCount)"
                    self.vwProperties.vwShoppingCount.isHidden = false
                }
            }
            
            if isShowNotificationCount == true {
                vwProperties.imgVwNotificationIcon.image = UIImage(named: "ic-Notification")
            } else {
                vwProperties.imgVwNotificationIcon.image = UIImage(named: "ic-Notifications1")
            }
        }
        objHomeVM.pageNumber = 0
        objHomeVM.recentlyListedApiMethod(0, isLoader: true) {
            self.vwProperties.colVwRecentlyListed.delegate = self.colVwDelegates
            self.vwProperties.colVwRecentlyListed.dataSource = self.colVwDataSource
            self.vwProperties.colVwRecentlyListed.reloadData()
        }
        
    }
        
       
}
