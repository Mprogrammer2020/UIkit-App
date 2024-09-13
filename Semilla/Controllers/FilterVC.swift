//
//  FilterVC.swift
//  Semilla
//
//  Created by netset on 07/12/23.
//

import UIKit

class FilterVC: UIViewController {
    
    //MARK: IBOutlet's
    @IBOutlet var vwProperties: FilterProperties!
    
    // MARK: Variable Declaration
    var objFilterVM = FilterVM()
    private var tblVwDataSource: FiltersDatasource!
    private var tblVwDelegates: FiltersDelegate!
    
    //MARK: Viewlife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        intializeViewDataSource()
    }
    
    //MARK: Custom Function
    private func intializeViewDataSource() {
        self.vwProperties.objFilterDelegates = self
        tblVwDataSource = FiltersDatasource(viewModel: objFilterVM, filterProperties: vwProperties)
        tblVwDelegates = FiltersDelegate(viewModel: objFilterVM, filterProperties: vwProperties)
        if self.objFilterVM.selectRatingValue != "" {
            if let index = self.objFilterVM.arrRatingsList.firstIndex(where: { $0.nameStr ?? "" == self.objFilterVM.selectRatingValue }) {
                self.objFilterVM.selectRatingIndex = index
            }
        }
        if objFilterVM.distance == 0 {
            objFilterVM.distance = 5
        }
        vwProperties.tblVwFilterData.delegate = tblVwDelegates
        vwProperties.tblVwFilterData.dataSource = tblVwDataSource
        vwProperties.tblVwFilterData.reloadData()
        tblVwDataSource.reloadTblVWCallback = {
            self.vwProperties.tblVwFilterData.reloadData()
        }
        //API Check
        objFilterVM.categeoriesApiMethod {
            self.vwProperties.tblVwFilterData.reloadData()
        }
    }
    
}
