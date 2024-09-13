//
//  FilterVCExt.swift
//  Semilla
//
//  Created by netset on 11/12/23.
//

import Foundation

extension FilterVC: DelegatesFilter {
    
    // MARK: - Button Back Clicked
    func gotoBack() {
        self.popViewController(true)
    }
    
    // MARK: - Button Reset Clicked
    func gotoReset() {
        objFilterVM.selectCategoryId.removeAllObjects()
        objFilterVM.selectRatingIndex = -1
        objFilterVM.distance = 5
        vwProperties.tblVwFilterData.reloadData()
        gotoApplyFilter()
    }
    
    // MARK: - Button Apply Filter Action's
    func gotoApplyFilter() {
        let cateIdArr = objFilterVM.selectCategoryId
        let ratingIndex = objFilterVM.selectRatingIndex
        let ratingVal = ratingIndex != -1 ? objFilterVM.arrRatingsList[ratingIndex].nameStr ?? "" : ""
        self.objFilterVM.callbackFilter?(cateIdArr,ratingVal,self.objFilterVM.distance)
        self.popViewController(true)
    }
    
}
