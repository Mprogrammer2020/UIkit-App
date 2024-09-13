//
//  CultivatorsDetailedVM.swift
//  Semilla
//
//  Created by Inder Sandhu on 18/12/23.
//

import UIKit

class CultivatorsDetailedVM {
    
    var objCultivatorData: CultivatorList?
    var objCultivatorProducts = [RecentListingDetails]()
    let refreshControl = UIRefreshControl()
    var pageNumber = 0
    var pageSize = 12
    var totalPages = Int()
    var cultivatorId = Int()
    var firstName = String()
    var lastName = String()
    var rating = Double()
    var Image = String()
    var isComingFrom = String()

    func cultivatorProductsApiMethod(_ id:Int,isLoader:Bool,completion:@escaping() -> Void) {
        let param = [
            AppParam.cultivatorList.page: "\(pageNumber)",
            AppParam.cultivatorList.size: "\(pageSize)",
            AppParam.cultivatorList.userId: "\(id)"
        ]
        WebServices.shared.postData(ApiUrl.cultivatorProducts, params: param, showIndicator: isLoader, methodType: .post, completion: { response in
            if self.pageNumber == 0 {
                self.objCultivatorProducts.removeAll()
            }
            if response.isSuccess {
                let apiData = Constants.shared.jsonDecoder.decode(model: RecentlyListed.self, data: response.data)!
                if self.pageNumber == 0 {
                    self.objCultivatorProducts = apiData.data?.list ?? []
                } else {
                    self.objCultivatorProducts = self.objCultivatorProducts + (apiData.data?.list ?? [])
                }
                let plusVal = ((apiData.data?.total ?? 0) % self.pageSize == 0 ? 0 : 1)
                self.totalPages = ((apiData.data?.total ?? 0) / self.pageSize) + plusVal
                
            }
            completion()
        })
    }
    
    
}
