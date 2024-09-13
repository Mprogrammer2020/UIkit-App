/* 
Copyright (c) 2024 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct ShoppingCartList : Codable {
	var id : Int?
    var stockId : Int?
    var productName : String?
    var productPrice : Double?
    var productCategory : String?
    var productImagePath : String?
    var pricePerUnit : Double?
    var productDescription : String?
    var packaging : Double?
    var unit : String?
    var totalQuantity : Int?
    var cultivatorId : Int?
    var availableStock : Int?
    var productTotalQuantity : Int?
    var productCultivatorId : Int?
    var productTotal : Double?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case stockId = "stockId"
		case productName = "productName"
		case productPrice = "productPrice"
		case productCategory = "productCategory"
		case productImagePath = "productImagePath"
		case pricePerUnit = "pricePerUnit"
		case productDescription = "productDescription"
		case packaging = "packaging"
		case unit = "unit"
        case totalQuantity = "totalQuantity"
		case cultivatorId = "cultivatorId"
        case availableStock = "availableStock"
        case productTotalQuantity = "productTotalQuantity"
        case productCultivatorId = "productCultivatorId"
        case productTotal = "productTotal"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		stockId = try values.decodeIfPresent(Int.self, forKey: .stockId)
		productName = try values.decodeIfPresent(String.self, forKey: .productName)
		productPrice = try values.decodeIfPresent(Double.self, forKey: .productPrice)
		productCategory = try values.decodeIfPresent(String.self, forKey: .productCategory)
		productImagePath = try values.decodeIfPresent(String.self, forKey: .productImagePath)
        pricePerUnit = try values.decodeIfPresent(Double.self, forKey: .pricePerUnit)
		productDescription = try values.decodeIfPresent(String.self, forKey: .productDescription)
        packaging = try values.decodeIfPresent(Double.self, forKey: .packaging)
		unit = try values.decodeIfPresent(String.self, forKey: .unit)
        totalQuantity = try values.decodeIfPresent(Int.self, forKey: .totalQuantity)
        cultivatorId = try values.decodeIfPresent(Int.self, forKey: .cultivatorId)
        availableStock = try values.decodeIfPresent(Int.self, forKey: .availableStock)
        productTotalQuantity = try values.decodeIfPresent(Int.self, forKey: .productTotalQuantity)
        productCultivatorId = try values.decodeIfPresent(Int.self, forKey: .productCultivatorId)
        productTotal = try values.decodeIfPresent(Double.self, forKey: .productTotal)
	}

}
