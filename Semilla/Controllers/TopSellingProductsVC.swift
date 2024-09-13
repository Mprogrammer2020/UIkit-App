//
//  TopSellingProductsVC.swift
//  Semilla
//
//  Created by Netset on 26/12/23.
//

import UIKit

class TopSellingProductsVC: UIViewController {
    
    //MARK: IBOutlet's
    @IBOutlet var vwProperties: TopSellingProductsProperties!
    
    //MARK: VariablesDeclaration
    var objTopSellingProductsVM = CultivatorsDetailedVM()
    var topSellingProductsTblVwDelegates: TopSellingProductsTblVwDelegates!
    var topSellingProductsTblVwDatasources: TopSellingProductsTblVwDatasource!
    
    //MARK: Viewlife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.intializeViewDataSource()
    }
    
    //MARK: Custom Function
    private func intializeViewDataSource() {
        self.vwProperties.objTopSellingProductsDelegate = self
        vwProperties.tblVwAllSellingProductsList.register(UINib.init(nibName: "ShoopingCartTVC", bundle: nil), forCellReuseIdentifier: "ShoopingCartTVC")
        
        topSellingProductsTblVwDelegates = TopSellingProductsTblVwDelegates(viewModel: objTopSellingProductsVM, TopSellingProductsProperties: vwProperties)
        topSellingProductsTblVwDatasources = TopSellingProductsTblVwDatasource(viewModel: objTopSellingProductsVM, TopSellingProductsProperties: vwProperties)
        
        vwProperties.tblVwAllSellingProductsList.delegate = topSellingProductsTblVwDelegates
        vwProperties.tblVwAllSellingProductsList.dataSource = topSellingProductsTblVwDatasources
        vwProperties.tblVwAllSellingProductsList.reloadData()
    }
    
}
