//
//  CustomerReviewsVC.swift
//  Semilla
//
//  Created by Netset on 25/01/24.
//

import UIKit

class CustomerReviewsVC: UIViewController {

    //MARK: IBOutlet's
    @IBOutlet var vwProperties: CustomerReviewsProperties!
    
    
    //MARK: Variable Declaration's
    var objViewModel = CustomerReviewsVM()
    var datasources: CustomerReviewsDataSources!
    var delegates: CustomerReviewsDelegates!
        
    
    //MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vwProperties.objDelegatesCustomerReviews = self
        datasources = CustomerReviewsDataSources(viewModel: objViewModel, properties: vwProperties)
        delegates = CustomerReviewsDelegates(objViewModel: objViewModel, properties: vwProperties)
        vwProperties.tblVwCustomerReviewsList.dataSource = datasources
        vwProperties.tblVwCustomerReviewsList.delegate = delegates
        vwProperties.tblVwCustomerReviewsList.reloadData()
    }
    

}
