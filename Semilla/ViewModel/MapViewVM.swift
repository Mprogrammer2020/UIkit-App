//
//  MapViewVM.swift
//  Semilla
//
//  Created by Netset on 05/03/24.
//

import UIKit
import GoogleMaps
import CoreLocation

class MapViewVM {
    
    var orderId = Int()
    var objOrderDetail : CheckoutOrder?
    var startMarker: GMSMarker?
    var endMarker: GMSMarker?
    var mutablePath = GMSMutablePath()
    var polyline = GMSPolyline()
    var startLoc = CLLocationCoordinate2D()
    var endLoc = CLLocationCoordinate2D()
    var updateMapCount = 0
    var objExtrasETA : ExtrasETAModel?
    
    func getOrderDetailApiMethod(_ completion:@escaping() -> Void) {
        WebServices.shared.getData("\(ApiUrl.orderDetails)/\(orderId)", showIndicator: true) { (response) in
            if response.isSuccess {
                let apiData = Constants.shared.jsonDecoder.decode(model: CheckoutModel.self, data: response.data)
                self.objOrderDetail = apiData?.data?.order
                self.objExtrasETA = apiData?.data?.order?.extras
                objDriverModel = apiData?.data?.order?.driver
                completion()
            }
        }
    }
    
}
