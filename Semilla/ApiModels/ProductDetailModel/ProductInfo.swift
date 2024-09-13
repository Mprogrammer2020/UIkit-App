/* 
Copyright (c) 2024 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation

struct ProductInfo : Codable {
    
	let id : Int?
	let createdDate : String?
	let rating : Double?
	let product : ProductCategory?
	let cultivator : User?
	let minOriginalPrice : Double?
	let minDiscountedPrice : Double?
	let enabled : Bool?
	let packaging : Int?
	let totalReview : Int?
	let unit : ProductUnit?
    var availableStock : Int?
    var cartQuantity : Int?
    var pricePerUnit : Double?
    var quantity : Int?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case createdDate = "createdDate"
		case rating = "rating"
		case product = "product"
		case cultivator = "cultivator"
		case minOriginalPrice = "minOriginalPrice"
		case minDiscountedPrice = "minDiscountedPrice"
		case enabled = "enabled"
		case packaging = "packaging"
		case totalReview = "totalReview"
		case unit = "unit"
        case availableStock = "availableStock"
        case cartQuantity = "cartQuantity"
        case pricePerUnit = "pricePerUnit"
        case quantity = "quantity"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		createdDate = try values.decodeIfPresent(String.self, forKey: .createdDate)
		rating = try values.decodeIfPresent(Double.self, forKey: .rating)
		product = try values.decodeIfPresent(ProductCategory.self, forKey: .product)
        cultivator = try values.decodeIfPresent(User.self, forKey: .cultivator)
		minOriginalPrice = try values.decodeIfPresent(Double.self, forKey: .minOriginalPrice)
		minDiscountedPrice = try values.decodeIfPresent(Double.self, forKey: .minDiscountedPrice)
		enabled = try values.decodeIfPresent(Bool.self, forKey: .enabled)
        packaging = try values.decodeIfPresent(Int.self, forKey: .packaging)
		totalReview = try values.decodeIfPresent(Int.self, forKey: .totalReview)
		unit = try values.decodeIfPresent(ProductUnit.self, forKey: .unit)
        availableStock = try values.decodeIfPresent(Int.self, forKey: .availableStock)
        cartQuantity = try values.decodeIfPresent(Int.self, forKey: .cartQuantity) ?? 0
        pricePerUnit = try values.decodeIfPresent(Double.self, forKey: .pricePerUnit)
        quantity = try values.decodeIfPresent(Int.self, forKey: .quantity)
	}

}

struct ProductCategory : Codable {
    
    let category : CategoryList?
    let id : Int?
    let createdDate : String?
    let description : String?
    let enabled : Bool?
    let name : String?
    let packaging : Double?
    let price : Double?
    let pricePerUnit: Double?
    let unit: ProductUnit?
    

    enum CodingKeys: String, CodingKey {

        case category = "category"
        case id = "id"
        case createdDate = "createdDate"
        case description = "description"
        case enabled = "enabled"
        case name = "name"
        case packaging = "packaging"
        case price = "price"
        case pricePerUnit = "pricePerUnit"
        case unit = "unit"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        createdDate = try values.decodeIfPresent(String.self, forKey: .createdDate)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        enabled = try values.decodeIfPresent(Bool.self, forKey: .enabled)
        category = try values.decodeIfPresent(CategoryList.self, forKey: .category)
        packaging = try values.decodeIfPresent(Double.self, forKey: .packaging)
        price = try values.decodeIfPresent(Double.self, forKey: .price)
        pricePerUnit = try values.decodeIfPresent(Double.self, forKey: .pricePerUnit)
        unit = try values.decodeIfPresent(ProductUnit.self, forKey: .unit)
        
    }

}
