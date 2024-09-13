//
//  CultivatorVC.swift
//  Semilla
//
//  Created by Netset on 05/12/23.
//

import UIKit

class CultivatorVC: UIViewController {
    
    //MARK: IBOutlet's
    @IBOutlet var vwProperties: CultivatorProperties!
    
    //MARK: Variable Declaration
    var objViewModel = CultivatorVM()
    private var colVwDatasources: CultivatorColVwDatasouces!
    private var colVwDelegates: CultivatorColVwDelegate!
    
    //MARK: Viewlife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.intializeViewDataSource()
    }
    
    //MARK: Custom Function
    private func intializeViewDataSource() {
        self.vwProperties.objCultivatorDelegate = self
        vwProperties.colVwUserList.register(UINib.init(nibName: "BestFarmersCVC", bundle: nil), forCellWithReuseIdentifier: "BestFarmersCVC")
        colVwDatasources = CultivatorColVwDatasouces(viewModel: objViewModel, properties: vwProperties)
        colVwDelegates = CultivatorColVwDelegate(viewModel: objViewModel, properties: vwProperties)
        objViewModel.refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        vwProperties.colVwUserList.refreshControl = objViewModel.refreshControl
        objViewModel.cultivatorListApiMethod(true) { [self] in
            vwProperties.colVwUserList.delegate = colVwDelegates
            vwProperties.colVwUserList.dataSource = colVwDatasources
            vwProperties.colVwUserList.reloadData()
        }
        colVwDelegates.callBackNavigateToCultivateDetailed = { indexPath in
            let data = self.objViewModel.arrCultivator[indexPath]
            CommonApis.shared.cultivatorOfflineApiMethod(data.id ?? 0) {
                if isOnline != true {
                    Alerts.shared.showAlert(title: AlertMessages.appName, message: ValidationMessages.cultivatorStatus)
                } else {
                    let vc = getStoryboard(.home).instantiateViewController(withIdentifier: ViewControllers.cultivatorsDetailedVC) as! CultivatorsDetailedVC
                    vc.objCultivatorsDetailedViewModel.cultivatorId = data.id ?? 0
                    vc.objCultivatorsDetailedViewModel.objCultivatorData = self.objViewModel.arrCultivator[indexPath]
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
        // Clear TextFields
        colVwDelegates.clearFields = {
            self.handleSearchData(self.vwProperties.txtFieldSearch.text ?? "")
        }
    }
    
    //MARK: - Refresh Data Action's
    @objc func refreshData(_ sender: Any) {
        objViewModel.pageNumber = 0
        objViewModel.cultivatorListApiMethod(false) {
            self.objViewModel.refreshControl.endRefreshing()
            self.vwProperties.colVwUserList.reloadData()
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
            if isShowNotificationCount == true {
                vwProperties.imgVwNotificationIcon.image = UIImage(named: "ic-Notification")
            } else {
                vwProperties.imgVwNotificationIcon.image = UIImage(named: "ic-Notifications1")
            }
        }
    }
}
