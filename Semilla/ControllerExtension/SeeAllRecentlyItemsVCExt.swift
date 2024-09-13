//
//  SeeAllRecentlyItemsVCExt.swift
//  Semilla
//
//  Created by Inder Sandhu on 18/12/23.
//

import Foundation

extension SeeAllRecentlyItemsVC: DelegatesSeeAllRecentlyItem {
    
    // MARK: Button Back Clicked
    func gotoBack() {
        self.popViewController(true)
    }
    
    // MARK: Handle Search Data Method
    func handleSearchData(_ textStr: String) {
        objSeeAllRecentlyVM.name = textStr
        objSeeAllRecentlyVM.recentlyListedApiMethod(objSeeAllRecentlyVM.selectCategoryId, isLoader: false) { [self] in
            vwProperties.colVwRecentlyItems.reloadData()
        }
    }
    
    // MARK: - Click Button Filter
    func goToFilterData() {
        self.pushToViewController(storyBoard: .home, Identifier: ViewControllers.filterVC, animated: true)
    }
    
}
