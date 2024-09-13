/* 
Copyright (c) 2024 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct ShoppingCartData : Codable {
    
	let total : TotalModelInfo?
	let list : [ShoppingCartList]?
    let extras : ExtrasETAModel?
    let Replace : String?
    let minimumOrderAmount : Double?

	enum CodingKeys: String, CodingKey {

		case total = "total"
		case list = "list"
        case extras = "extras"
        case Replace = "Replace"
        case minimumOrderAmount = "minimumOrderAmount"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		total = try values.decodeIfPresent(TotalModelInfo.self, forKey: .total)
		list = try values.decodeIfPresent([ShoppingCartList].self, forKey: .list)
        extras = try values.decodeIfPresent(ExtrasETAModel.self, forKey: .extras)
        Replace = try values.decodeIfPresent(String.self, forKey: .Replace)
        minimumOrderAmount = try values.decodeIfPresent(Double.self, forKey: .minimumOrderAmount)
	}

}

struct TotalModelInfo : Codable {
    
    let cartTotal : Double?
    let deliveryFee : Double?
    let itemTotal: Double?
    let serviceFee: Double?
    let estimatedDeliveryTime : String?
    let creditsUsed : Double?
    let totalAfterCredits : Double?
    let virtualCredits : Double?
    

    enum CodingKeys: String, CodingKey {

        case cartTotal = "cartTotal"
        case deliveryFee = "deliveryFee"
        case itemTotal = "itemTotal"
        case serviceFee = "serviceFee"
        case estimatedDeliveryTime = "estimatedDeliveryTime"
        case creditsUsed = "creditsUsed"
        case totalAfterCredits = "totalAfterCredits"
        case virtualCredits = "virtualCredits"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cartTotal = try values.decodeIfPresent(Double.self, forKey: .cartTotal)
        deliveryFee = try values.decodeIfPresent(Double.self, forKey: .deliveryFee)
        itemTotal = try values.decodeIfPresent(Double.self, forKey: .itemTotal)
        serviceFee = try values.decodeIfPresent(Double.self, forKey: .serviceFee)
        estimatedDeliveryTime = try values.decodeIfPresent(String.self, forKey: .estimatedDeliveryTime)
        creditsUsed = try values.decodeIfPresent(Double.self, forKey: .creditsUsed)
        totalAfterCredits = try values.decodeIfPresent(Double.self, forKey: .totalAfterCredits)
        virtualCredits = try values.decodeIfPresent(Double.self, forKey: .virtualCredits)
        
    }

}

struct ExtrasETAModel : Codable {
    
    let distance : String?
    let eta : String?
    let deliverable : Bool?
    let total : TotalModelInfo?

    enum CodingKeys: String, CodingKey {

        case distance = "distance"
        case eta = "eta"
        case total = "total"
        case deliverable = "deliverable"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        distance = try values.decodeIfPresent(String.self, forKey: .distance)
        eta = try values.decodeIfPresent(String.self, forKey: .eta)
        total = try values.decodeIfPresent(TotalModelInfo.self, forKey: .total)
        deliverable = try values.decodeIfPresent(Bool.self, forKey: .deliverable)
    }

}
