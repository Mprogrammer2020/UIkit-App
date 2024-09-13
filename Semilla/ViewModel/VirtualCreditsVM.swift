//
//  VirtualCreditsVM.swift
//  Semilla
//
//  Created by Netset on 23/04/24.
//

import Foundation
import UIKit

class VirtualCreditsVM {
    
    var objVirtualCredits = [VirtualCreditsList]()
    var objVirtualCreditsData : VirtualCreditsData?
    var pageNumber = 0
    var pageSize = 10
    var totalPages = Int()
    let refreshControl = UIRefreshControl()
    
    func creditsHistoryApiMethod(_ isLoading: Bool,completion:@escaping() -> Void) {
        WebServices.shared.getData("\(ApiUrl.virtualCredits)/page/\(pageNumber)/size/\(pageSize)", showIndicator: isLoading) { (response) in
            if self.pageNumber == 0 {
                self.objVirtualCredits.removeAll()
            }
            if response.isSuccess {
                let apiData = Constants.shared.jsonDecoder.decode(model: VirtualCreditsModel.self, data: response.data)
                if self.pageNumber == 0 {
                    self.objVirtualCredits.removeAll()
                    self.objVirtualCredits = (apiData?.data?.list ?? [])
                    self.objVirtualCreditsData = apiData?.data
                } else {
                    self.objVirtualCredits = self.objVirtualCredits + (apiData?.data?.list ?? [])
                }
                let plusVal = ((apiData?.data?.total ?? 0) % self.pageSize) == 0 ? 0 : 1
                self.totalPages = ((apiData?.data?.total ?? 0) / self.pageSize) + plusVal
                debugPrint("self.totalPages",self.totalPages)
            }
            completion()
        }
    }
}
    

