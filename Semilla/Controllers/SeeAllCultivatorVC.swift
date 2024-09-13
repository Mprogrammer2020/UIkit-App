//
//  SeeAllCultivatorVC.swift
//  Semilla
//
//  Created by Inder Sandhu on 18/12/23.
//

import UIKit

class SeeAllCultivatorVC: UIViewController {
    
    //MARK: IBOutlet's
    @IBOutlet var vwProperties: SeeAllCultivatorProperties!
    
    //MARK: Variable Declaration
    var objViewModel = CultivatorVM()
    private var colVwSeeAllCultivatorDatasources: SeeAllCultivatorsDatasources!
    private var colVwSeeAllCultivatorDelegates: SeeAllCultivatorsDelegates!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: Viewlife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        intializeViewDataSource()
    }
    
    //MARK: Custom Function
    private func intializeViewDataSource() {
        self.vwProperties.objSeeAllCultivatorDelegates = self
        vwProperties.colVwCutivatorsList.register(UINib.init(nibName: "BestFarmersCVC", bundle: nil), forCellWithReuseIdentifier: "BestFarmersCVC")
        colVwSeeAllCultivatorDatasources = SeeAllCultivatorsDatasources(viewModel: objViewModel, properties: vwProperties)
        colVwSeeAllCultivatorDelegates = SeeAllCultivatorsDelegates(viewModel: objViewModel, properties: vwProperties)
        vwProperties.colVwCutivatorsList.delegate = colVwSeeAllCultivatorDelegates
        vwProperties.colVwCutivatorsList.dataSource = colVwSeeAllCultivatorDatasources
        vwProperties.colVwCutivatorsList.reloadData()
        
        //On Item Click
        colVwSeeAllCultivatorDelegates.callBackNavigateToCultivateDetailed = { index in
            let vc = getStoryboard(.home).instantiateViewController(withIdentifier: ViewControllers.cultivatorsDetailedVC) as! CultivatorsDetailedVC
//            vc.userImage = self.objViewModel.myTesting[index].userImages ?? ""
//            vc.userName = self.objViewModel.myTesting[index].userName ?? ""
//            vc.objDataCheck = self.objViewModel.myTesting[index]
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
}
