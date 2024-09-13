//
//  SearchHistoryVCExt.swift
//  Semilla
//
//  Created by Netset on 21/12/23.
//

import Foundation

extension SearchHistoryVC: DelegatesSearchHistory {
    
    // MARK: - Button Back Clicked
    func gotoBack() {
        self.popViewController(false)
    }
    
    func goToFilter() {
        self.pushToViewController(storyBoard: .home, Identifier: ViewControllers.filterVC, animated: true)
    }
    
    // MARK: - Handle Search Data Method
    func handleSearchData(_ textStr: String) {
        objSearchHistoryVM.pageNumber = 0
        objSearchHistoryVM.name = textStr
        if vwProperties.txtFldSearch.isBlank {
            objSearchHistoryVM.searchListedApiMethod(objSearchHistoryVM.selectCategoryId, isLoader: true) {
                self.vwProperties.colVwSearchItems.reloadData()
            }
        } else {
            objSearchHistoryVM.recentlyListedApiMethod(objSearchHistoryVM.selectCategoryId, isLoader: false) {
                self.vwProperties.colVwSearchItems.reloadData()
            }
        }
    }
    
}
