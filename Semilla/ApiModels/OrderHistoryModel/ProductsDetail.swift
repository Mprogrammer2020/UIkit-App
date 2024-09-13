/* 
Copyright (c) 2024 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct ProductsDetail : Codable {
	let productName : String?
	let packaging : Double?
	let unit : String?
	let productPrice : Double?
	let productTotalQuantity : Int?
	let productTotal : Double?
	let productImagePath : String?

	enum CodingKeys: String, CodingKey {

		case productName = "productName"
		case packaging = "packaging"
		case unit = "unit"
		case productPrice = "productPrice"
		case productTotalQuantity = "productTotalQuantity"
		case productTotal = "productTotal"
		case productImagePath = "productImagePath"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		productName = try values.decodeIfPresent(String.self, forKey: .productName)
		packaging = try values.decodeIfPresent(Double.self, forKey: .packaging)
		unit = try values.decodeIfPresent(String.self, forKey: .unit)
		productPrice = try values.decodeIfPresent(Double.self, forKey: .productPrice)
		productTotalQuantity = try values.decodeIfPresent(Int.self, forKey: .productTotalQuantity)
		productTotal = try values.decodeIfPresent(Double.self, forKey: .productTotal)
		productImagePath = try values.decodeIfPresent(String.self, forKey: .productImagePath)
	}

}
