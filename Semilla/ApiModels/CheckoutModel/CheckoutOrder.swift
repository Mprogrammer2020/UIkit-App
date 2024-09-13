/* 
Copyright (c) 2024 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation

struct CheckoutOrder : Codable {
    
	let id : Int?
	let orderDate : String?
	let deliveryAddress : Address?
	let grossAmount : Double?
	let deliveryFee : Double?
	let totalAmount : Double?
    let serviceFee : Double?
    let creditsUsed : Double?
	let status : String?
	let totalItems : Int?
	let lastActionDate : String?
	let scheduleCount : Int?
	let customer : Customer?
	let cultivator : CheckOutCultivator?
	let driver : Driver?
    let otp : String?
    let products : [ShoppingCartList]?
    let extras : ExtrasETAModel?
    let driverName : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case orderDate = "orderDate"
		case deliveryAddress = "deliveryAddress"
		case grossAmount = "grossAmount"
        case deliveryFee = "deliveryFee"
        case serviceFee = "serviceFee"
		case creditsUsed = "creditsUsed"
		case totalAmount = "totalAmount"
		case status = "status"
		case totalItems = "totalItems"
		case lastActionDate = "lastActionDate"
		case scheduleCount = "scheduleCount"
		case customer = "customer"
		case cultivator = "cultivator"
		case driver = "driver"
        case otp = "otp"
        case products = "products"
        case extras = "extras"
        case driverName = "driverName"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
        orderDate = try values.decodeIfPresent(String.self, forKey: .orderDate)
        driverName = try values.decodeIfPresent(String.self, forKey: .driverName)
        deliveryAddress = try values.decodeIfPresent(Address.self, forKey: .deliveryAddress)
		grossAmount = try values.decodeIfPresent(Double.self, forKey: .grossAmount)
        deliveryFee = try values.decodeIfPresent(Double.self, forKey: .deliveryFee)
        serviceFee = try values.decodeIfPresent(Double.self, forKey: .serviceFee)
        creditsUsed = try values.decodeIfPresent(Double.self, forKey: .creditsUsed)
		totalAmount = try values.decodeIfPresent(Double.self, forKey: .totalAmount)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		totalItems = try values.decodeIfPresent(Int.self, forKey: .totalItems)
		lastActionDate = try values.decodeIfPresent(String.self, forKey: .lastActionDate)
		scheduleCount = try values.decodeIfPresent(Int.self, forKey: .scheduleCount)
		customer = try values.decodeIfPresent(Customer.self, forKey: .customer)
        cultivator = try values.decodeIfPresent(CheckOutCultivator.self, forKey: .cultivator)
        driver = try values.decodeIfPresent(Driver.self, forKey: .driver)
        otp = try values.decodeIfPresent(String.self, forKey: .otp)
        products = try values.decodeIfPresent([ShoppingCartList].self, forKey: .products)
        let extrasStr = try values.decodeIfPresent(String.self, forKey: .extras)
        if extrasStr != nil {
            let extrasData = Data((extrasStr ?? "").utf8)
            let apiData = Constants.shared.jsonDecoder.decode(model: ExtrasETAModel.self, data: extrasData)
            extras = apiData
        } else {
            extras = nil
        }
	}

}
