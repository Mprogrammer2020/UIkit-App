//
//  CultivatorsDetailedVCExt.swift
//  Semilla
//
//  Created by Inder Sandhu on 18/12/23.
//

import Foundation

extension CultivatorsDetailedVC: DelegatesCultivatorsDetailed {
    
    // MARK: -Button Back Clicked
    func gotoBack() {
        self.popViewController(true)
    }
    
    // MARK: - Button SeeAll Top Selling Products Clicked
    func gotoAllTopSellingProducts() {
        self.pushToViewController(storyBoard: .home, Identifier: ViewControllers.topSellingProductsVC, animated: true)
    }
    
    // MARK: - Button SeeAll Our Products Clicked
    func gotoAllOurProducts() {
        let vc = getStoryboard(.home).instantiateViewController(withIdentifier: ViewControllers.ourProductsVC) as! OurProductsVC
        vc.objOurProductsVM.cultivatorId = objCultivatorsDetailedViewModel.cultivatorId
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
