/* 
Copyright (c) 2024 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct CultivatorData : Codable {
	let yearOfExperience : Double?
	let typeOfCultivation : String?
	let documentPath : String?
	let businessName : String?
	let verificationDocument : String?
	let city : String?
	let country : String?
	let rating : Double?
	let totalReview : Int?
	let bankName : String?
	let accountNumber : String?
	let accountHolderName : String?
	let routingNumber : String?

	enum CodingKeys: String, CodingKey {

		case yearOfExperience = "yearOfExperience"
		case typeOfCultivation = "typeOfCultivation"
		case documentPath = "documentPath"
		case businessName = "businessName"
		case verificationDocument = "verificationDocument"
		case city = "city"
		case country = "country"
		case rating = "rating"
		case totalReview = "totalReview"
		case bankName = "bankName"
		case accountNumber = "accountNumber"
		case accountHolderName = "accountHolderName"
		case routingNumber = "routingNumber"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		yearOfExperience = try values.decodeIfPresent(Double.self, forKey: .yearOfExperience)
		typeOfCultivation = try values.decodeIfPresent(String.self, forKey: .typeOfCultivation)
		documentPath = try values.decodeIfPresent(String.self, forKey: .documentPath)
		businessName = try values.decodeIfPresent(String.self, forKey: .businessName)
		verificationDocument = try values.decodeIfPresent(String.self, forKey: .verificationDocument)
		city = try values.decodeIfPresent(String.self, forKey: .city)
		country = try values.decodeIfPresent(String.self, forKey: .country)
		rating = try values.decodeIfPresent(Double.self, forKey: .rating)
		totalReview = try values.decodeIfPresent(Int.self, forKey: .totalReview)
		bankName = try values.decodeIfPresent(String.self, forKey: .bankName)
		accountNumber = try values.decodeIfPresent(String.self, forKey: .accountNumber)
		accountHolderName = try values.decodeIfPresent(String.self, forKey: .accountHolderName)
		routingNumber = try values.decodeIfPresent(String.self, forKey: .routingNumber)
	}

}
