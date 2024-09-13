/* 
Copyright (c) 2024 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct OrdersList : Codable {
	let orderId : Int?
	let cultivatorId : Int?
	let orderDate : String?
	let orderStatusDate : String?
	let customerName : String?
	let driverName : String?
	let status : String?
	let totalAmount : Double?
	let totalItems : Int?
	let products : [ShoppingCartList]?

	enum CodingKeys: String, CodingKey {

		case orderId = "orderId"
		case cultivatorId = "cultivatorId"
		case orderDate = "orderDate"
		case orderStatusDate = "orderStatusDate"
		case customerName = "customerName"
		case driverName = "driverName"
		case status = "status"
		case totalAmount = "totalAmount"
		case totalItems = "totalItems"
		case products = "products"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		orderId = try values.decodeIfPresent(Int.self, forKey: .orderId)
		cultivatorId = try values.decodeIfPresent(Int.self, forKey: .cultivatorId)
		orderDate = try values.decodeIfPresent(String.self, forKey: .orderDate)
		orderStatusDate = try values.decodeIfPresent(String.self, forKey: .orderStatusDate)
		customerName = try values.decodeIfPresent(String.self, forKey: .customerName)
		driverName = try values.decodeIfPresent(String.self, forKey: .driverName)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		totalAmount = try values.decodeIfPresent(Double.self, forKey: .totalAmount)
		totalItems = try values.decodeIfPresent(Int.self, forKey: .totalItems)
		products = try values.decodeIfPresent([ShoppingCartList].self, forKey: .products)
	}

}
